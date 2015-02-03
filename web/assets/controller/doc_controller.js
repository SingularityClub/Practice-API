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
            .when("/doc/evaluate", {
                controller: 'docEvaluateController',
                templateUrl: 'views/docs/evaluate.html'
            })
            .when("/doc/package", {
                controller: 'docPackageController',
                templateUrl: 'views/docs/package.html'
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
    .controller("docPackageController", ["$scope", "markdownService", function ($scope, markdownService) {
        markdownService.load('views/docs/package.md', function (content) {
            $scope.md_html = content;
            $scope.$$phase || $scope.$apply();
        });
    }])
    .controller("docEvaluateController", ["$scope", "markdownService", function ($scope, markdownService) {
        markdownService.load('views/docs/evaluate.md', function (content) {
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
    .directive("scrollToTop", ["$document", function ($document) {
        return {
            link: function (scope, ele, attrs) {
                angular.element(ele).click(function () {
                    $document.scrollTopAnimated(0);
                })
            }
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
            });
        }
    }])
;
