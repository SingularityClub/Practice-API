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
###Users 用户
**GET `/api/users`    获取所有用户**

返回：
```javascript
    [{
        `username`:[string],//用户名
        `name`:[string],    //真实姓名
        `email`:[string],   //电子邮件
        `gender`:[integer]  //性别
        
    }]//数组              
```

**POST `/api/users/reg`   注册用户**

参数：
```javascript
    {
        `username`:[string],
        `password`:[string],
        `gender`:[integer]        //可选。0:未知，1:男，2:女
    }
```
返回：
```javascript
    {
        `id`:[integer],     //id
        `username`:[string],//用户名
        `name`:[string],    //真实姓名
        `email`:[string],   //电子邮件
        `gender`:[integer]  //性别
    }
```

**POST `/api/users/login` 登录**

参数：
```js
    {
        `username`:[string],
        `password`:[string]
    }
```
返回
```js
    {
        `id`:[integer],     //id
        `username`:[string],//用户名
        `name`:[string],    //真实姓名
        `email`:[string],   //电子邮件
        `gender`:[integer]  //性别
    }
```

**POST `/api/users/logout`    注销**


**GET `/api/users/current`    获取当前登录用户**

返回
```js
    {
        `id`:[integer],     //id
        `username`:[string],//用户名
        `name`:[string],    //真实姓名
        `email`:[string],   //电子邮件
        `gender`:[integer]  //性别
    }
```

**GET `/api/users/:id`  按id获取用户信息**

参数
```js
    {
        `id`:[integer]  //用户id
    }
```
返回
```js
    {
        `id`:[integer],     //id
        `username`:[string],//用户名
        `name`:[string],    //真实姓名
        `email`:[string],   //电子邮件
        `gender`:[integer]  //性别
    }
```

**PUT `/api/users/:id`  按ID修改用户**

参数
```js
    {
        `id`:[integer],         //用户id
        `name`:[string],        //姓名
        `email`:[string],       //电子邮件
        `password`:[string],    //密码，不修改密码留空，修改密码后需要重新登录
        `gender`:[integer]      //性别，0:未知，1:男，2:女
    }
```
返回
```js
    {
        `id`:[integer],     //id
        `username`:[string],//用户名
        `name`:[string],    //真实姓名
        `email`:[string],   //电子邮件
        `gender`:[integer]  //性别
    }
```

**DELETE `api/users/:id`    按ID删除用户**

参数
```js
    {
        `id`:[integer]  //用户id
    }
```


###Article   文章

**GET `/api/articles`   获取文章列表或按标签名获取**

参数
```js
    {
        `start`:[integer],  //可选，默认：0。从某索引开始获取
        `end`:[integer],    //可选，默认：100。截止到某索引完毕，最多获取100条，超过则按end=start+100算
        `tagname`:[string], //可选，若传入了标签名，则获取改标签下的文章
    }
```
返回
```js
    {
        `data`:[{                           //文章数组
            `id`:[integer],                 //文章id
            `title`:[integer],              //标题
            `content`:[string],             //内容
            `views`:[integer],              //浏览次数
            `user_id`:[integer],            //作者id
            `created_at`:[date],            //发表日期
            `comment_count`:[integer],      //评论个数
            `updated_at`:[date],            //修改日期
            `user`:{                        //作者实体
                `id`:[integer],             //作者id
                `username`:[string],        //作者用户名
                `name`:[string]             //作者姓名
            },
            `tags`:[{                       //标签数组
                `title`:[string]            //标签标题
            }]
        }],
        `count`:[integer],                  //本次分页条数
        `start`:[integer],                  //从某索引开始
        `end`:[integer]                     //到某索引结束
    }
```

**POST `/api/articles`  添加文章**

参数
```js
    {
        `title`:[string],       //标题
        `tags`:[Array:string]   //标签，数组，可选。用于分类，最多5个，操作则记录前5个
        `content`:[string]      //内容
    }
```
返回
```js
    {
        `id`:[integer],                 //文章id
        `title`:[integer],              //标题
        `content`:[string],             //内容
        `views`:[integer],              //浏览次数
        `user_id`:[integer],            //作者id
        `created_at`:[date],            //发表日期
        `comment_count`:[integer],      //评论个数
        `updated_at`:[date],            //修改日期
    }
```

**GET `/api/articles/:id`   按id获取文章**

参数
```js
    {
        `id`:[integer]  //文章id
    }
```
返回
```js
    {
        `id`:[integer],                 //文章id
        `title`:[integer],              //标题
        `content`:[string],             //内容
        `views`:[integer],              //浏览次数
        `user_id`:[integer],            //作者id
        `created_at`:[date],            //发表日期
        `comment_count`:[integer],      //评论个数
        `updated_at`:[date],            //修改日期
        `user`:{                        //作者实体
            `id`:[integer],             //作者id
            `username`:[string],        //作者用户名
            `name`:[string]             //作者姓名
        },
        `tags`:[{                       //标签数组
            `title`:[string]            //标签标题
        }]
    }
```

**PUT `/api/articles/:id`   按id修改文章内容**

参数
```js
    {
        `contnet`:[string]      //文章内容
    }
```
返回
```js
    {
        `id`:[integer],                 //文章id
        `title`:[integer],              //标题
        `content`:[string],             //内容
        `views`:[integer],              //浏览次数
        `user_id`:[integer],            //作者id
        `created_at`:[date],            //发表日期
        `comment_count`:[integer],      //评论个数
        `updated_at`:[date],            //修改日期
        `user`:{                        //作者实体
            `id`:[integer],             //作者id
            `username`:[string],        //作者用户名
            `name`:[string]             //作者姓名
        },
        `tags`:[{                       //标签数组
            `title`:[string]            //标签标题
        }]
    }
```

**DELETE `/api/articles/:id`    按id删除文章**

参数
```js
    {
        `id`:[integer]  //文章id
    }
```

