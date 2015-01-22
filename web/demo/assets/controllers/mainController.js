angular.module("Etrain", [
    'ngMaterial', 'Etrain.Service.User', 'ngAnimate', 'Etrain.Article', 'ngRoute',
    'Etrain.Service.Toolkit', 'Etrain.Service.Article'
])
    .config(['$routeProvider', "$httpProvider", function ($routeProvider, $httpProvider) {
        $routeProvider
            .when("/", {
                controller: 'indexController',
                templateUrl: 'views/index.html'
            })
            .when("/login", {
                controller: 'loginController',
                templateUrl: 'views/login.html'
            })
            .when("/setting", {
                controller: 'settingController',
                templateUrl: 'views/setting.html'
            });

        $httpProvider.defaults.withCredentials = true;
        $httpProvider.interceptors.push(["$rootScope", "$q", "$timeout", function ($rootScope, $q, $timeout) {
            return {
                'request': function (config) {
                    $rootScope.Config.Loading = $rootScope.Config.Loading || 0;
                    $timeout(function () {
                        $rootScope.Config.Loading += 1;
                    }, 200);
                    return config || $q.when(config);
                },
                'response': function (rejection) {
                    $rootScope.Config.Loading = $rootScope.Config.Loading || 0;
                    $rootScope.Config.Loading -= 1;
                    return rejection || $q.when(rejection);
                },
                'responseError': function (rejection) {
                    $rootScope.Config.Loading -= 1;
                    if (rejection.status == 500)
                        $rootScope.Toolkit.exceptionHandler.Handle(rejection.data);
                    if (rejection.status == 401 && "message" in rejection.data)
                        $rootScope.Toolkit.exceptionHandler.Handle(rejection.data);
                    return $q.reject(rejection);
                }
            };
        }]);
    }])
    .controller("mainController", ['$scope', '$mdSidenav', "$location", "$rootScope", "$toolkit", "userService",
        function ($scope, $mdSidenav, $location, $rootScope, $toolkit, userService) {
            $rootScope.Config = {
                User: null,
                Module: "",
                OAuthUser: null
            };
            $rootScope.GlobalFun = {
                Logout: function () {
                    userService.Logout();
                },
                RefreshUser: function () {
                    $rootScope.Config.User =
                        userService.User.current(function (content) {
                        });
                }
            };
            $rootScope.GlobalFun.RefreshUser();

            $rootScope.NavTrace = $toolkit.NavTrace;
            $rootScope.Toolkit = $toolkit;

            $scope.$on('$routeChangeSuccess', function (obj, end, start) {
                $rootScope.NavTrace.clear();
            });

            $scope.location = $location;

            $scope.$mdSidenav = $mdSidenav;
        }])
    .controller("indexController", ['$scope', "$location", function ($scope, $location) {
        $scope.controller_name = "indexController";
        $location.path("article")
    }])
    .controller("loginController", ["$scope", "userService", "$toolkit", "$rootScope", "$location",
        function ($scope, userService, $toolkit, $rootScope, $location) {
            $rootScope.Config.Module = "Login";
            $scope.NavTrace.unshift("登录", "#/login");
            $scope.login = new userService.User();
            $scope.reg = new userService.User({gender: '1'});
            $scope.Login = function (user) {
                user.$login(function (user) {
                    $scope.Config.User = user;
                    $location.path('/')
                }, function (res) {
                });
            };
            $scope.Reg = function (user) {
                $scope.temp_password = angular.copy(user.password);
                user.$reg(function () {
                    $toolkit.Notice.show("注册成功，正在自动登录");
                    user.password = $scope.temp_password;
                    $scope.Login(user, function () {
                        delete $scope.temp_password;
                    });
                }, function () {
                })
            };
        }])
    .controller("settingController", ["$scope", "userService", "$mdToast", "$location", "$toolkit",
        function ($scope, userService, $mdToast, $location, $toolkit) {
            if (!$scope.Config.User)
                return $location.path('/');
            $scope.NavTrace.unshift("设置", "#/setting");
            $scope.user = userService.User.current(function (user) {
                user.gender = String(user.gender);
            });

            $scope.SelfEdit = function (user) {
                $scope.user.$editCurrent({
                    old_password: user.old_password,
                    name: user.name,
                    email: user.email,
                    password: user.password,
                    gender: user.gender
                }, function (user) {
                    user.gender = String(user.gender);
                    $toolkit.Notice.show("修改成功，若修改了密码则需要重新登陆");

                    $scope.GlobalFun.RefreshUser();
                })
            }

        }])
;