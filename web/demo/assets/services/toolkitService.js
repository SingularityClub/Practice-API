/**
 * Created by tavern on 14/12/17.
 */
angular.module("Etrain.Service.Toolkit", ["ngMaterial", "ngResource"])
    .service("$toolkit", ["$mdToast", "$mdDialog", "$resource", "$rootScope", "$location",
        function ($mdToast, $mdDialog, $resource, $rootScope, $location) {
            var $this = this;

            this.Tag = $resource(config.prefix + "/tags", {}, {
                ban: {method: "delete", url: config.prefix + "/articles/:article_id/comments/:id"}
            });

            //用户是否登录
            this.Authorize = function (cb) {
                if (!$rootScope.Config.User.id) {
                    if (cb)cb();
                    history.back()
                }
            };

            //markdown编辑器
            this.markdownEditor = function (elementID, cb) {
                marked.setOptions({
                    highlight: function (code) {
                        return hljs.highlightAuto(code).value;
                    }
                });
                cb();
            };
            //导航跟踪
            this.NavTrace = {
                _traces: [],
                push: function (obj) {
                    if (angular.isObject(obj))
                        this._traces.push(obj);
                    else if (angular.isString(arguments[0]) && angular.isString(arguments[1]))
                        this._traces.push({title: arguments[0], url: arguments[1]});
                },
                unshift: function (obj) {
                    if (angular.isObject(obj))
                        this._traces.unshift(obj);
                    else if (angular.isString(arguments[0]) && angular.isString(arguments[1]))
                        this._traces.unshift({title: arguments[0], url: arguments[1]});
                },
                clear: function () {
                    delete this._traces;
                    this._traces = [];
                }
            };
            //日期按指定转化
            this.DateParse = function (date, formart) {
                var datetime = new Date(Date.parse(date));
                return datetime.Format(formart);
            };

            //确认框
            this.Confirm = {
                show: function (title, content, okLabel, cancelLabel, okFunc, cancelFunc, e) {
                    var confirm = $mdDialog.confirm()
                        .title(title)
                        .content(content)
                        .ok(okLabel)
                        .cancel(cancelLabel)
                        .targetEvent(e);
                    $mdDialog.show(confirm).then(okFunc, cancelFunc);
                }
            };

            //弹出框通知
            this.Dialog = {
                show: function (title, content, okLabel) {
                    $mdDialog.show(
                        $mdDialog.alert().title(title).content(content)
                            .ok(okLabel || "确定")
                        //.targetEvent(ev)
                    );
                }
            };

            //消息通知
            this.Notice = {
                show: function (message, position) {
                    if (!position) position = "top right ";
                    var obj = $mdToast.simple().content(message).position(position);
                    $mdToast.show(obj);
                }
            };
            //异常处理
            this.exceptionHandler = {
                Handle: function (err) {
                    err.name = err.name || "";
                    var msg = err.message;
                    $this.Notice.show(msg);
                }
            }
        }
    ])