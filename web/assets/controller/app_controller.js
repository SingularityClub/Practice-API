/**
 * Created by Tavern on 2015/1/20 0020.
 */
window.app = angular.module("Practice", ["ngRoute", "Practice.Doc"])
    .config(['$routeProvider', "$httpProvider", function ($routeProvider, $httpProvider) {
        $routeProvider
            .when("/", {
                controller: 'homeController',
                templateUrl: 'views/home.html'
            }).otherwise({redirectTo: '/'})
    }])
    .controller("mainController", ["$scope", "$location", function ($scope, $location) {
    }])
    .controller("homeController", ["$scope", "$location", function ($scope, $location) {
        $location.path("doc/blog_api");

    }])
;
