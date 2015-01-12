# Practice-API
API for SingularityClub

##API简介

- 本项目是奇点俱乐部的练习程序
- 纯后端，不包含前端以及演示代码
- 采用Ruby的Grape框架编写
- API尽量符合标准
- 本项目是一套极简的完整博客后端

##API功能包含

- 用户
- 文章
- 文章标签
- 文章评论
- 第三方登录**（如：微博、微信，开发中）

##API Document
- Users 用户

|请求谓词|API|参数(中括号为可选)|返回|介绍|
|:------:|:--|:---|:--:|:--:|
|GET|`/api/users`||用户实体:Array|获取所有用户|
|POST|`/api/users`|`username`*:string*<br>`password`*:string*<br>[`gender`*:integer(0:未知，1:男，2:女)*]|用户实体:Object|添加用户
|POST|`/api/users/login`|`username`*:string*<br>`password`*:string*|用户实体:Object|登录|
|POST|`/api/users/logout`||null|注销|
|GET|`/api/users/current`||用户实体:Object|当前登录用户|
|GET|`/api/users/:id`|`id`*:integer*|用户实体:Object|按id获取用户信息|
|PUT|`/api/users/:id`|`id`*:integer*<br>[`name`*:string*] 真实姓名<br>[`email`*:string*] <br>[`password`*:string*] <br>[`gender`*:integer*]   |用户实体:Object|修改id的用户,不修改密码请将密码留空|
|DELETE|`api/users/:id`|`id`*:integer*|null|按id删除用户|

- Article   文章

|请求谓词|API|参数(中括号为可选)|返回|介绍|
|:------:|:--:|:--|:--:|----|
|GET|`/api/articles`|[`start`*:integer*]<br>[`end`*:integer*]<br>[`tagname`*:string*]|文章列表:Array|获取文章列表或按标签名获取|
|POST|`/api/articles`|`title`*:string*<br>`tags`*:string:Array*<br>`content`*:string*|文章实体:Object|添加文章。tags为字符串数组，最多5个，自动添加。|
|GET|`/api/articles/:id`|`id`*:integer*|文章实体:Object|按id获取文章|
|PUT|`/api/articles/:id`|`id`*:integer*<br>`content`*:string*|文章实体:Object|按id修改文章内容|
|DELETE|`/api/articles/:id`|`id`*:integer*|null|按id删除文章|

    
