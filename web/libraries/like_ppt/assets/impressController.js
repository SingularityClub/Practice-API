process.on('uncaughtException', function (e) {
    console.error(e.message)
});
Array.prototype.remove = function (obj) {
    if (typeof obj == "number") {
        return this.splice(obj, 1);
    }
    else {
        var index = this.indexOf(obj);
        if (index > -1)
            return this.splice(index, 1);
    }
}
angular.module("SingularityClub1", [])
    .controller("impress", ["$scope", "$interval", function ($scope, $interval) {
        $('[data-toggle="tooltip"]').tooltip();

        $interval(function () {
            $('[data-toggle="popover"]').popover()
        }, 1000);

        $scope.remove = function (obj) {
            if (obj != "js" && obj != "javascript")
                $scope.langs.remove(obj)
        };

        $scope.langs_dic = {
            "c": {text: "C", description: "静态，驱动开发，嵌入式，底层"},
            "c++": {text: "C++", description: "面向对象，静态，大型程序，高性能，游戏"},
            "c#": {text: "C#", description: "面向对象，静态，跨平台，快速开发，企业应用，服务器程序，桌面程序"},
            "java": {text: "Java", description: "面向对象，静态，跨平台，快速开发，企业应用，安卓应用"},
            "oc": {text: "Objective-C", description: "面向对象，静态，C语言扩充，MAC OS程序，IOS程序"},
            "php": {text: "PHP", description: "面向对象，脚本语言，只能做网站，服务器语言"},
            "python": {text: "Python", description: "面向对象，脚本语言，语法简单，科学计算，游戏，网络程序"},
            "javascript": {
                text: "Javascript",
                description: "基于对象，脚本语言，语法简单，浏览器直接运行，社区活跃"
            },
            "js": {
                text: "Javascript",
                description: "基于对象，脚本语言，语法简单，浏览器直接运行，社区活跃"
            },
            "perl": {text: "Perl", description: "面向对象，脚本语言，UNIX系统维护"},
            "vb": {
                text: "Visual Basic",
                description: "语法简单 快速开发 企业应用"
            },
            "vb.net": {text: "Visual Basic .Net", description: "是VB在.NET框架上的实现"},
            "tsql": {text: "Transact-SQL", description: "是 SQL 在 Microsoft SQL Server 上的增强版"},
            "ruby": {text: "Ruby", description: "面向对象，元编程，脚本语言，现代web启蒙者，网络程序，Rails "},
            "pascal": {text: "Pascal", description: "快速开发，版本众多"},
            "j#": {text: "J#", description: "语法类似JAVA，.Net框架下的Java"},
            "sql": {text: "SQL", description: "数据库查询语言，结构化语言，脚本语言"},
            "swift": {
                text: "Swift",
                description: "面向对象，快速开发，MAC OS程序，IOS程序"
            },
            "as": {
                text: "ActionScript",
                description: "面向对象，脚本语言，结构化，Flash应用"
            },
            "lisp": {text: "Lisp", description: "一种基于λ演算的函数式编程语言。"},
            "matlab": {text: "MatLab", description: "数学软件，用于算法开发，数据可视化，数据分析以，数值计算"},
            "go": {text: "GO", description: "快速开发，网络应用"},
            "汇编": {text: "Assembly", description: "是面向机器的程序设计语言。"},
            "scala": {
                text: "Scala",
                description: "函数式编程，类似JAVA，JVM"
            },
            "lua": {text: "Lua", description: "脚本语言，小巧，简单，魔兽世界脚本，仙5"},
            "erlang": {text: "Erlang", description: "面向并发，函数式，服务器应用"},
            "tcl": {text: "TCL", description: "脚本语言，快速原型开发，GUI，测试"},
            "groovy": {text: "Groovy", description: "面向对象，快速开发，JVM"},
            "vf": {text: "Visual FoxPro", description: "开发数据库，简单"},
            "clojue": {text: "Clojue", description: "是一种运行在Java平台上的 Lisp 方言"},
            "css": {text: "CSS", description: "层叠样式表语言，给HTML配置样式"},
            "less": {text: "LESS", description: "动态层叠样式表语言"},
            "sass": {text: "SASS", description: "扩展CSS3，增加了规则、变量、混入、选择器、继承等等特性"},
            "html": {text: "HTML", description: "超文本标记语言"},
            "vbs": {text: "VBScript", description: "是基于Visual Basic的脚本语言。"},
            "f#": {text: "F#", description: "函数式编程，.NET平台的计算辅助语言"}
        }
    }]);
