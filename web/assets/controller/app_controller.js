/**
 * Created by Tavern on 2015/1/20 0020.
 */
angular.module("Practice", ["ngRoute","Practice.Doc"])
    .config(['$routeProvider', "$httpProvider", function ($routeProvider, $httpProvider) {
        $routeProvider
            .when("/", {
                controller: 'homeController',
                templateUrl: 'views/home.html'
            })
    }])
    .controller("mainController", ["$scope", function ($scope) {

    }])
    .controller("homeController", ["$scope", function ($scope) {

    }])
;
