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
    .controller("scoreController", function ($scope) {
        $scope.data = {
            ann: [120, 90, 73, 86, 80, 85.8],
            dhd: [120, 70, 78, 92, 90, 94.3],
            jll: [120, 80, 73, 89, 90, 91.75],
            ljj: [120, 100, 78, 89, 70, 85.5],
            lsy: [120, 80, 72, 88, 80, 85.8],
            lxx: [120, 80, 79, 94, 80, 95.05],
            lwl: [120, 80, 68, 83, 80, 83.35],
            wjj: [120, 80, 80, 93, 80, 93.85],
            xxy: [120, 80, 71, 91, 80, 87.2],
            zyong: [120, 70, 79, 91, 90, 93.7],
            zyuan: [120, 80, 76, 87, 100, 96.15],
            zx: [120, 0, 68, 81, 90, 75.95],
            zj: [120, 90, 72, 92, 100, 95.9]
        }

        $scope.labels = ["满分", "文档", "UI", "Javascript库", "代码", "总分"]
        $scope.dataset = function (data) {
            return [{
                label: "score",
                fillColor: "rgba(151,187,205,0.2)",
                strokeColor: "rgba(151,187,205,1)",
                pointColor: "rgba(151,187,205,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(151,187,205,1)",
                data: data
            }];
        }
    })
    .directive("radarChart", function () {
        return {
            link: function (scope, ele, attrs) {
                var data = scope.data[attrs['radarChart']];
                var dataset = scope.dataset(data)
                var ctx = document.getElementById(attrs['radarChart']).getContext("2d");
                var myRadarChart = new Chart(ctx).Radar({
                    labels: scope.labels,
                    datasets: dataset

                });
            }
        }
    })
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
