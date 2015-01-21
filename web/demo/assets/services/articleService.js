/**
 * Created by Tavern on 2014/12/18 0018.
 */

angular.module("Etrain.Service.Article", ["ngResource"])
    .service("articleService", ["$resource", "$rootScope", function ($resource, $rootScope) {
        var url = config.prefix + "/articles/:id";
        var $this = this;
        this.Article = $resource(url, {id: "@id"}, {
            commentPost: {method: "post", url: config.prefix + "/articles/:id/comments"},
            comments: {method: "get", url: config.prefix + "/articles/:id/comments", isArray: true}
        });
    }])

;