/**
 * Created by Tavern on 2014/12/18 0018.
 */

angular.module("Etrain.Service.Comment", ["ngResource"])
    .service("commentService", ["$resource", "$rootScope", function ($resource, $rootScope) {
        var url = config.prefix + "/articles/:id";
        var $this = this;
        this.Article = $resource(url, {id: "@id"}, {
            commentPost: {method: "post"}
        });
    }])

;