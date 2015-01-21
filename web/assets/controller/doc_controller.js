/**
 * Created by Tavern on 2015/1/20 0020.
 */
angular.module("Practice.Doc", ["ngRoute", "ngSanitize"])
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
    .controller("docHomeController", ["$scope", function ($scope) {

    }])
    .controller("docBlogApiController", ["$scope", "markdownService", function ($scope, markdownService) {
        markdownService.load('views/docs/api.md', function (content) {
            $scope.md_html = content;
            $scope.$$phase || $scope.$apply();
        });
    }])
    .service("markdownService", [function () {
        marked.setOptions({
            highlight: function (code) {
                return hljs.highlightAuto(code).value;
            }
        });

        this.load = function (url, cb) {
            cb = cb || function () {
            };
            $.get(url).success(function (content) {
                cb(marked(content));
            });
        }
    }])
;
