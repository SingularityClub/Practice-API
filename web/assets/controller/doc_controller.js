/**
 * Created by Tavern on 2015/1/20 0020.
 */
angular.module("Practice.Doc", ["ngRoute"])
    .config(['$routeProvider', "$httpProvider", function ($routeProvider, $httpProvider) {
        $routeProvider
            .when("/doc", {
                controller: 'docHomeController',
                templateUrl: 'views/docs/index.html'
            })
    }])
    .controller("docHomeController", ["$scope", function ($scope) {

    }])
;
