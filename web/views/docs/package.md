#前端常用库

###Bootstrap <i class="fa fa-css3 fa-fw"></i></a><span id="bootstrap"></span>

一个前端最受欢迎的CSS框架。涵盖常用的各种样式组件。
- 文档：http://v3.bootcss.com/

- bower

    ```sh
    bower install bootstrap3
    ```

- cdn

    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script src="http://cdn.bootcss.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    ```

###FontAwesome <i class="fa fa-css3 fa-fw"></i></a><span id="fontawesome"></span>

最流行的前端图标集。包罗万象。

- 文档：http://fontawesome.io/icons/

- bower

    ```sh
    bower install fontawesome
    ```

- cdn

    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.2.0/css/font-awesome.min.css">
    ```

###AngularJS <span id="angularjs"></span>

前端MVVM框架，SingularityClub必会框架。下面只记录了4个最常用的angular库：`angular`,`angular-animate`,`angular-resource`,`angular-route`。目前版本1.3.8。

- 文档：http://docs.angularjs.org/api  (需要翻墙)

- bower

    ```sh
    bower install angular angular-route angular-resource angular-animate
    ```

- cdn

    ```html
    <script src="http://cdn.bootcss.com/angular.js/1.3.8/angular.min.js"></script>
    <script src="http://cdn.bootcss.com/angular.js/1.3.8/angular-animate.min.js"></script>
    <script src="http://cdn.bootcss.com/angular.js/1.3.8/angular-resource.min.js"></script>
    <script src="http://cdn.bootcss.com/angular.js/1.3.8/angular-route.min.js"></script>
    ```

###jQuery <span id="jquery"></span>

前端必用工具库之一

- 首页：http://jquery.com/

- bower
    ```sh
    bower install jquery
    ```
- cdn
    ```html
    <script src="http://cdn.bootcss.com/jquery/2.1.3/jquery.min.js"></script>
    ```

###Foundation <i class="fa fa-css3 fa-fw"></i></a><span id="foundation"></span>

另一个与Bootstrap齐肩的CSS框架

- 首页：http://foundation.zurb.com

- bower
    ```sh
    bower install foundation
    ```
- cdn
    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/foundation/5.5.0/css/foundation.min.css">
    <script src="http://cdn.bootcss.com/foundation/5.5.0/js/foundation.min.js"></script>
    ```

###Animate.css <i class="fa fa-css3 fa-fw"></i></a> <span id="animatecss"></span>

一个动画CSS框架，只需要在某标签上加上特定的class，就会出现非常绚丽的效果。

- 演示：http://daneden.github.io/animate.css/

- 文档：https://github.com/daneden/animate.css

- bower
    ```sh
    bower install animate.css
    ```
- cdn
    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/animate.css/3.2.0/animate.min.css">
    ```

###Moment.js <span id="momentjs"></span>

一个时间JS库，JS本身对时间这个类型支持不好。有了这个库就方便太多。

- 文档：http://momentjs.com/docs/

- bower
    ```sh
    bower install moment
    ```
- cdn
    ```html
    <script src="http://cdn.bootcss.com/moment.js/2.9.0/moment-with-locales.min.js"></script>
    ```

###Three.js <span id="threejs"></span>

JS的轻量级3D库，使用`<canvas>`,`<svg>`,`WebGL`渲染。

- 演示：http://threejs.org/

- 文档：http://threejs.org/docs/index.html#Manual/Introduction/Creating_a_scene

- bower
    ```sh
    bower install three.js
    ```
- cdn
    ```html
    <script src="http://cdn.bootcss.com/three.js/r70/three.min.js"></script>
    ```

###Impress.js <span id="impressjs"></span>

非常炫酷的前端展览库，比PPT强了几个档次。SingularityClub前端第一课的演示课件也是用的这个库做的。

- 演示：http://bartaz.github.io/impress.js/

- 文档：https://github.com/bartaz/impress.js/wiki/Html-attributes

- bower
    ```sh
    bower install impress.js
    ```
- cdn
    ```html
    <script src="http://cdn.bootcss.com/impress.js/0.5.3/impress.min.js"></script>
    ```

###Reveal.js <span id="revealjs"></span>

同Impress.js，前端展览库，类似PPT。

- 演示：http://lab.hakim.se/reveal-js/#/

- 文档：https://github.com/hakimel/reveal.js

- bower
    ```sh
    bower install reveal.js
    ```
- cdn
    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/reveal.js/2.6.2/css/reveal.min.css">
    <!--- 以下是reveal的皮肤
    http://cdn.bootcss.com/reveal.js/2.6.2/css/print/paper.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/print/pdf.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/beige.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/blood.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/default.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/moon.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/night.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/serif.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/simple.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/sky.css
    http://cdn.bootcss.com/reveal.js/2.6.2/css/theme/solarized.css
    http://cdn.bootcss.com/reveal.js/2.6.2/lib/css/zenburn.css
    --->
    <script src="http://cdn.bootcss.com/reveal.js/2.6.2/js/reveal.min.js"></script>
    ```

###Select2 <span id="select2"></span>

一个功能非常强大的选择器插件，有多种展示形式，也有多种实用方法。

- 演示和文档：https://select2.github.io/examples.html

- bower
    ```sh
    bower install select2
    ```
- cdn
    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/select2/4.0.0-beta.2/css/select2.min.css">
    <script src="http://cdn.bootcss.com/select2/4.0.0-beta.2/js/select2.min.js"></script>
    ```

###Chart.js <span id="charjs"></span>

HTML5实现的报表UI生成库

- 演示和文档：http://www.chartjs.org/docs/

- bower
    ```sh
    bower install chartjs
    ```
- cdn
    ```html
    <script src="http://cdn.bootcss.com/Chart.js/1.0.1-beta.4/Chart.min.js"></script>
    ```

###Sweetalert <span id="sweetalert"></span>

一个非常简单的，又非常可爱的弹出框，多用于替换浏览器默认的弹出框。

- 演示和文档：http://tristanedwards.me/sweetalert

- bower
    ```sh
    bower install sweetalert
    ```
-cdn
    ```html
    <link rel="stylesheet" href="http://cdn.bootcss.com/sweetalert/0.4.0/sweet-alert.min.js">
    <script src="http://cdn.bootcss.com/sweetalert/0.4.0/sweet-alert.min.js">
    ```

###Typeahead.js <span id="typeaheadjs"></span>

提示输入栏，Twitter提供，可以开启WebGL加速。类似百度谷歌搜索框的下拉输入提示，不过这个更强大。

- 演示：http://twitter.github.io/typeahead.js/examples/

- 项目页： https://github.com/twitter/typeahead.js

- bower
    ```sh
    bower install typeahead.js
    ```

###Timelinejs <span id="timelinejs"></span>

很炫酷的时间线UI插件。仅此一家！

- 演示：http://timeline.knightlab.com/#examples  （需要翻墙）

- 文档： https://github.com/NUKnightLab/TimelineJS

- bower
    ```sh
    bower install timeline.js
    ```




