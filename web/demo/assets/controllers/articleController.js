/**
 * Created by Tavern on 2014/12/16 0016.
 */
angular.module("Etrain.Article", ["ngRoute", "Etrain.Service.Toolkit", 'Etrain.Service.Article', "ngSanitize", "bgf.paginateAnything", 'ui.ace', 'ui.select'])
    .config(['$routeProvider', function ($routeProvider) {
        $routeProvider
            .when("/article", {
                controller: 'articleIndex',
                templateUrl: 'views/Article/index.html'
            })
            .when("/article/:tag/index", {
                controller: 'articleIndex',
                templateUrl: 'views/Article/index.html'
            })
            .when("/article/new", {
                controller: 'articleNew',
                templateUrl: 'views/Article/new.html'
            })
            .when("/article/:id/view", {
                controller: 'articleView',
                templateUrl: 'views/Article/view.html'
            })
    }])
    .controller("articleWrap", ["$scope", "$rootScope", "$mdDialog", function ($scope, $rootScope, $mdDialog) {
        $scope.NavTrace.unshift("博客", "#/article");
        $rootScope.Config.Module = "Article";
    }])
    .controller("articleIndex", ["$scope", "$mdDialog", "articleService", "$toolkit", "$routeParams", "$location",
        function ($scope, $mdDialog, articleService, $toolkit, $routeParams, $location) {
            $scope.tag = $routeParams.tag;
            //列表展现形式
            localStorage['article_show_type'] = $scope.article_show_type = localStorage['article_show_type'] || "line";

            $scope.changeArticleShowType = function (type) {
                localStorage['article_show_type'] = $scope.article_show_type = type;
            };

            if ($scope.tag)
                $scope.NavTrace.unshift($scope.tag, "#/article/" + $scope.tag + "/index");
            $scope.NavTrace.unshift("列表", "#/article");

            //获取mark
            $scope.tags = $toolkit.Tag.query(function (content) {
                var all = {id: 0, title: "全部"};
                content.unshift(all);
                //如果不存在所选tag
                if (!$scope.tag)
                    $scope.selectedTag = all;
                else {
                    $scope.selectedTag = $.grep(content, function (item) {
                        return item.title == $scope.tag
                    })[0];
                }
            });
            $scope.articleUrl = $scope.tag ? config.prefix + "/articles?tagname=" + $scope.tag : config.prefix + "/articles";

            //注册markdown和高亮
            marked.setOptions({
                highlight: function (code) {
                    return hljs.highlightAuto(code).value;
                }
            });
            $scope.marked = marked;

            /**
             * @return {string}
             */
            $scope.TagSelect = function (tag) {
                if (tag.id == 0) return $location.path('article');
                $location.path('article/' + tag.title + '/index')
            };


            $scope.DateParse = $toolkit.DateParse;
        }])
    .controller("articleNew", ["$scope", "articleService", "$toolkit", "$location", "$interval"
        , function ($scope, articleService, $toolkit, $location, $interval) {
            $scope.NavTrace.unshift("新建", "#/article/new");
            $toolkit.Authorize(function () {
            });

            $scope.articleReset = function () {
                localStorage['article_new'] = angular.toJson({content: "", tags: []});
                $scope.article = {content: "", tags: []};
            };

            if (localStorage['article_new'])
                try {
                    $scope.article = angular.fromJson(localStorage['article_new']);
                } catch (e) {
                    $scope.articleReset();
                }
            else
                $scope.articleReset();


            //ctrl+s 保存
            $(document).keydown(function (e) {
                if (e.ctrlKey && e.keyCode == 83) {
                    e.preventDefault();
                }
            });
            $scope.keydown = function (e) {
                if (e.ctrlKey && e.keyCode == 83) {
                    $toolkit.Confirm.show("保存", "本文章即将保存，是否继续？", "保存", "取消"
                        , function () {
                            var post_article = new articleService.Article($scope.article);
                            post_article.title = post_article.content.split('\n')[0].trim();
                            if (post_article.title[0] == '#')
                                post_article.title = post_article.title.substring(1).trim();
                            post_article.$save(function () {
                                $scope.articleReset();
                                $toolkit.Confirm.show("成功", "保存文章成功", "返回列表", "继续撰写"
                                    , function () {
                                        $location.path("article");
                                    }
                                    , function () {
                                    }, $scope.$event);
                            });
                        }, function () {

                        }, e);
                }
            };

            $toolkit.markdownEditor("editor", function () {
                $scope.Preview = function () {
                    if ($scope.article.content)
                        $scope.preview = marked($scope.article.content);
                };

                //间隔保存
                $interval(function () {
                    localStorage["article_new"] = angular.toJson($scope.article || {content: "", tags: []});
                }, 5000)
            });

            $scope.countries = [];
        }])
    .controller("articleView", ["$scope", "articleService", "$toolkit", "$routeParams", "$location",
        function ($scope, articleService, $toolkit, $routeParams, $location) {
            $scope.id = $routeParams.id;

            marked.setOptions({
                highlight: function (code) {
                    return hljs.highlightAuto(code).value;
                }
            });

            $scope.article = articleService.Article.get({id: $scope.id}, function (content) {
                $scope.NavTrace.push(content.title, "#/article/" + $scope.id + "/view");
                content.content = marked(content.content)
            });

            $scope.marked = marked;

            $scope.CommentReview = function () {
                $scope.preview = marked($scope.comment.content);
                $scope.preview_show = !$scope.preview_show;
            };

            $scope.keydown = function (e) {
                if (e.ctrlKey && e.keyCode == 83) {
                    $toolkit.Confirm.show("保存", "本评论即将保存，是否继续？", "保存", "取消"
                        , function () {
                            articleService.Article.commentPost({
                                id: $scope.article.id,
                                content: $scope.comment.content,
                                account: $scope.Config.OAuthUser
                            }, function () {
                                $scope.comment_reload = true;
                                $scope.comment = {content: ''};
                                $toolkit.Notice.show("评论成功！")
                            });
                        }, function () {

                        }, e);
                }
            };

            $scope.disable = function () {
                $toolkit.Confirm.show("确认", "真的要禁用本文？", "是", "否"
                    , function () {
                        $scope.article.$delete(function () {
                            $toolkit.Notice.show("已禁用")
                            $location.path("article")
                        })
                    }, function () {

                    }, event);
            };

            $scope.comment_disable = function () {

            };

            $scope.comment_delete = function () {

            };

            //ctrl+s 保存
            $(document).keydown(function (e) {
                if (e.ctrlKey && e.keyCode == 83) {
                    e.preventDefault();
                }
            });

            $scope.DateParse = $toolkit.DateParse;
        }])
    .directive("weiboLoginButton", function () {
        return {
            link: function (scope, ele, attrs) {
                WB2.anyWhere(function (W) {
                    W.widget.connectButton({
                        id: attrs['id'],//"wb_connect_btn",
                        type: "4,3",
                        callback: {
                            login: function (o) {	//登录后的回调函数
                                $scope.Config.OAuthUser = o;
                                $scope.$$phase || $scope.$apply();
                            },
                            logout: function () {	//退出后的回调函数
                                $scope.Config.OAuthUser = null;
                                $scope.$$phase || $scope.$apply();
                            }
                        }
                    });
                });
            }
        }
    });