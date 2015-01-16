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

##运行此程序

数据库配置文档：`config/database.yml`

步骤：

1. 安装所需所有gem：`bundle`
2. 数据迁移：`rake db:migrate RACK_ENV=?`
    
    注：?是环境，对应于数据库配置文档。环境：`development`, `test`, `production`，默认运行环境：`development`
3. 运行：`ruby server.rb -e [env] -p [port]`

    注：`[env]`是环境，同数据库环境。`[port]`是端口。参数参考：[Goliath](https://github.com/postrank-labs/goliath/wiki/Server)

##rspec测试

测试文件在：`tests`目录下

##Linux生产环境运行

别忘了`bundle`和数据迁移。`run.sh`以*daemon*的方式运行该程序，日志文件在：`logs/log.log`。端口默认：8000，若有需要请自行修改。运行环境是`production`，请注意`config/database.yml`设置。

```bash
bash run.sh
```


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

    
