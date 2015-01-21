# Practice-API简介

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

##Rspec测试

测试文件在：`tests`目录下

##Linux生产环境运行

别忘了`bundle`和数据迁移。`run.sh`以*daemon*的方式运行该程序，日志文件在：`logs/log.log`。端口默认：8000，若有需要请自行修改。运行环境是`production`，请注意`config/database.yml`设置。

```bash
bash run.sh
```
