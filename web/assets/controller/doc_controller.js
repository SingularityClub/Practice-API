/**
 * Created by Tavern on 2015/1/20 0020.
 */
angular.module("Practice.Doc", ["ngRoute", "ngSanitize", "duScroll"])
    .config(['$routeProvider', "$httpProvider", function ($routeProvider, $httpProvider) {
        $routeProvider
            .when("/doc", {
                controller: 'docHomeController',
                templateUrl: 'views/docs/index.html'
            })
            .when("/doc/blog_api", {
                controller: 'docBlogApiController',
                templateUrl: 'views/docs/index.html'
            })
    }])
    .controller("docHomeController", ["$scope", "markdownService", function ($scope, markdownService) {
        markdownService.load('views/docs/app.md', function (content) {
            $scope.md_html = content;
            $scope.$$phase || $scope.$apply();
        });

    }])
    .controller("docBlogApiController", ["$scope", "markdownService", function ($scope, markdownService) {
        markdownService.load('views/docs/api.md', function (content) {
            $scope.md_html = content;
            $scope.$$phase || $scope.$apply();
        });
    }])
    .controller("utilsController", ["$scope", "$location", "$anchorScroll", "$document"
        , function ($scope, $location, $anchorScroll, $document) {
            $scope.go = function (id) {
                $document.scrollToElementAnimated(angular.element("#" + id));
            }
        }])
    .service("markdownService", ["$sce", function ($sce) {
        marked.setOptions({
            highlight: function (code) {
                return hljs.highlightAuto(code).value;
            }
        });

        this.load = function (url, cb) {
            cb = cb || function () {
            };
            $.get(url).success(function (content) {
                cb($sce.trustAsHtml(marked(content)));

                console.log($("#doc_content").height())

                $("#doc_nav").parent().height($("#doc_content").height());

                $("#doc_nav").pin({containerSelector: ".api-sider", padding: {top: 30, bottom: 10}});
            });
        }
    }])
;
