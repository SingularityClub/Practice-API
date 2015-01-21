##API Document
###Users 用户
**GET `/api/users`    获取所有用户**

返回：
```javascript
    [{
        'username':[string],//用户名
        'name':[string],    //真实姓名
        'email':[string],   //电子邮件
        'gender':[integer]  //性别

    }]//数组
```

**POST `/api/users/reg`   注册用户**

参数：
```javascript
    {
        'username':[string],
        'password':[string],
        'gender':[integer]        //可选。0:未知，1:男，2:女
    }
```
返回：
```javascript
    {
        'id':[integer],     //id
        'username':[string],//用户名
        'name':[string],    //真实姓名
        'email':[string],   //电子邮件
        'gender':[integer]  //性别
    }
```

**POST `/api/users/login` 登录**

参数：
```js
    {
        'username':[string],
        'password':[string]
    }
```
返回
```js
    {
        'id':[integer],     //id
        'username':[string],//用户名
        'name':[string],    //真实姓名
        'email':[string],   //电子邮件
        'gender':[integer]  //性别
    }
```

**POST `/api/users/logout`    注销**


**GET `/api/users/current`    获取当前登录用户**

返回
```js
    {
        'id':[integer],     //id
        'username':[string],//用户名
        'name':[string],    //真实姓名
        'email':[string],   //电子邮件
        'gender':[integer]  //性别
    }
```

**GET `/api/users/:id`  按id获取用户信息**

参数
```js
    {
        'id':[integer]  //用户id
    }
```
返回
```js
    {
        'id':[integer],     //id
        'username':[string],//用户名
        'name':[string],    //真实姓名
        'email':[string],   //电子邮件
        'gender':[integer]  //性别
    }
```

**PUT `/api/users/:id`  按ID修改用户**

参数
```js
    {
        'id':[integer],         //用户id
        'name':[string],        //姓名
        'email':[string],       //电子邮件
        'password':[string],    //密码，不修改密码留空，修改密码后需要重新登录
        'gender':[integer]      //性别，0:未知，1:男，2:女
    }
```
返回
```js
    {
        'id':[integer],     //id
        'username':[string],//用户名
        'name':[string],    //真实姓名
        'email':[string],   //电子邮件
        'gender':[integer]  //性别
    }
```

**DELETE `api/users/:id`    按ID删除用户**

参数
```js
    {
        'id':[integer]  //用户id
    }
```


###Article   文章

**GET `/api/articles`   获取文章列表或按标签名获取**

参数
```js
    {
        'start':[integer],  //可选，默认：0。从某索引开始获取
        'end':[integer],    //可选，默认：100。截止到某索引完毕，最多获取100条，超过则按end=start+100算
        'tagname':[string], //可选，若传入了标签名，则获取改标签下的文章
    }
```
返回
```js
    {
        'data':[{                       //文章数组
            'id':[integer],                 //文章id
            'title':[integer],              //标题
            'content':[string],             //内容
            'views':[integer],              //浏览次数
            'user_id':[integer],            //作者id
            'created_at':[date],            //发表日期
            'comment_count':[integer],      //评论个数
            'updated_at':[date],            //修改日期
            'user':{                        //作者实体
                'id':[integer],             //作者id
                'username':[string],        //作者用户名
                'name':[string]             //作者姓名
            },
            'tags':[{                       //标签数组
                'title':[string]            //标签标题
                }]
        }],
        'count':[integer],                  //本次分页条数
        'start':[integer],                  //从某索引开始
        'end':[integer]                     //到某索引结束
    }
```

**POST `/api/articles`  添加文章**

参数
```js
    {
        'title':[string],       //标题
        'tags':[Array:string]   //标签，数组，可选。用于分类，最多5个，操作则记录前5个
        'content':[string]      //内容
    }
```
返回
```js
    {
        'id':[integer],                 //文章id
        'title':[integer],              //标题
        'content':[string],             //内容
        'views':[integer],              //浏览次数
        'user_id':[integer],            //作者id
        'created_at':[date],            //发表日期
        'comment_count':[integer],      //评论个数
        'updated_at':[date],            //修改日期
    }
```

**GET '/api/articles/:id'   按id获取文章**

参数
```js
    {
        'id':[integer]  //文章id
    }
```
返回
```js
    {
        'id':[integer],                 //文章id
        'title':[integer],              //标题
        'content':[string],             //内容
        'views':[integer],              //浏览次数
        'user_id':[integer],            //作者id
        'created_at':[date],            //发表日期
        'comment_count':[integer],      //评论个数
        'updated_at':[date],            //修改日期
        'user':{                        //作者实体
            'id':[integer],             //作者id
            'username':[string],        //作者用户名
            'name':[string]             //作者姓名
        },
        'tags':[{                       //标签数组
            'title':[string]            //标签标题
        }]
    }
```

**PUT `/api/articles/:id`   按id修改文章内容**

参数
```js
    {
        'contnet':[string]      //文章内容
    }
```
返回
```js
    {
        'id':[integer],                 //文章id
        'title':[integer],              //标题
        'content':[string],             //内容
        'views':[integer],              //浏览次数
        'user_id':[integer],            //作者id
        'created_at':[date],            //发表日期
        'comment_count':[integer],      //评论个数
        'updated_at':[date],            //修改日期
        'user':{                        //作者实体
            'id':[integer],             //作者id
            'username':[string],        //作者用户名
            'name':[string]             //作者姓名
        },
        'tags':[{                       //标签数组
            `title`:[string]            //标签标题
        }]
    }
```

**DELETE `/api/articles/:id`    按id删除文章**

参数
```js
    {
        'id':[integer]  //文章id
    }
```

###Comments 评论

**GET `/api/article/:id/comments`  按文章获取评论·分页**

参数
```js
    {
        'id':[integer],      //文章id
        'start':[integer],  //可选，默认：0。从某索引开始获取
        'end':[integer],    //可选，默认：100。截止到某索引完毕，最多获取100条，超过则按end=start+100算
    }
```
返回
```js
    {
        'data':[{                       //评论数组
            'id':[integer],             //评论id
            'content':[string],         //评论内容
            'created_at':[date]         //评论时间
        }],
        'count':[integer],                  //本次分页条数
        'start':[integer],                  //从某索引开始
        'end':[integer]                     //到某索引结束
    }
```