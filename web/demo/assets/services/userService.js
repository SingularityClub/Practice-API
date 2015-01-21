/**
 * Created by tavern on 14/12/16.
 */
angular.module("Etrain.Service.User", ["ngResource"])
    .service("userService", ["$resource", "$rootScope", function ($resource, $rootScope) {
        var url = config.prefix + "/users/:id";
        var $this = this;
        this.User = $resource(url, {id: "@id"}, {
            login: {method: "post", url: config.prefix + "/users/login"},
            reg: {method: "post", url: config.prefix + "/users/reg"},
            current: {method: "get", url: config.prefix + "/users/current"},
            logout: {method: "post", url: config.prefix + "/users/logout"}
        });
        this.Logout = function () {
            $this.User.logout(function () {
                $rootScope.Config.User = {$resolved: true}
            });
        }
    }])

;