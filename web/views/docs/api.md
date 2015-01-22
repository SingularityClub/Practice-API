#博客API文档
### **简介** <span id="info"></span>

学弟学妹们，由于本博客程序本是设计成团队博客。但考虑到集训的时间关系，将精简成单用户博客。采用以下处理方式：
- **将前缀修改**

    如： `/api/articles` =>  `/[your name]/articles`

    前缀（`/api`）改成你的`/用户名`（自由取值），本程序会自动为你这个用户名创建一个博客，并且与其他人的博客分离开来。
    默认密码为：`123456`。通过PUT `/[your name]/users/current`的`api`来修改你的密码。

- **精简用户管理**

    用户管理对你们而言，只存在`获取当前用户`、`登录`、`注销`、`修改资料`

- **数据传输均用`json`格式**

    本次集训，要求的前端框架是angularjs，所以传输数据默认是`json`。

### **Users 用户** <span id='users'></span>
- **<a id="user_all">GET `/[your name]/users` 获取所有用户</a>**

    `需要管理员权限`，请忽略此API

    返回
    ```js
        [{
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别

        }]//数组
    ```

-  **<a>POST `/[your name]/users/reg`   注册用户</a>**

    `需要管理员权限`，请忽略此API

    为了让开发简单，精简用户管理。

    参数
    ```javascript
        {
            'username':[string]*,
            'password':[string]*,
            'gender':[int]        //可选。0:未知，1:男，2:女
        }
    ```
    返回
    ```javascript
        {
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```



- **<a id="login">POST `/[your name]/users/login` 登录</a>**

    登录之后会向你的浏览器写入cookie，记录你的登录信息。7天的有效时间，之后调用api不需要重复登陆。

    若是第一次登陆，默认密码为：`123456`

    参数
    ```js
        {
            'username':[string]*,
            'password':[string]*
        }
    ```
    返回
    ```js
        {
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```

- **<a id="logout">POST `/[your name]/users/logout`    注销</a>**

    清除cookie，之后所有`需要登录`的api将不能使用。


- **<a id="current_user">GET `/[your name]/users/current`    获取当前登录用户</a>**

    `需要登陆`

    登录之后，从cookie里读取信息，返回当前登录的用户。没登陆则返回：null

    返回
    ```js
        {
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```

- **<a>GET `/[your name]/users/:id`  按id获取用户信息</a>**

    `需要管理员权限`，请忽略此API

    参数
    ```js
        {
            'id':[int]  //用户id
        }
    ```
    返回
    ```js
        {
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```

- **<a id="edit_current_user">PUT `/[your name]/users/current`  按修改当前用户的资料</a>**

    `需要登陆`

    不修改密码，则将`password`留空，`old_password`为校验密码，必填。

    参数
    ```js
        {
            'old_password':[string]* //旧密码
            'name':[string],        //姓名
            'email':[string],       //电子邮件
            'password':[string],    //密码，不修改密码留空，修改密码后需要重新登录
            'gender':[int]      //性别，0:未知，1:男，2:女
        }
    ```
    返回
    ```js
        {
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```

- **<a>PUT `/[your name]/users/:id`  按ID修改用户</a>**

    `需要管理员权限`，请忽略此API

    参数
    ```js
        {
            'id':[int]*,         //用户id
            'name':[string],        //姓名
            'email':[string],       //电子邮件
            'password':[string],    //密码，不修改密码留空，修改密码后需要重新登录
            'gender':[int]      //性别，0:未知，1:男，2:女
        }
    ```
    返回
    ```js
        {
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```

- **<a>DELETE `[your name]/users/:id`    按ID删除用户</a>**

    `需要管理员权限`，请忽略此API

    参数
    ```js
        {
            'id':[int]  //用户id
        }
    ```


### **Article   博文**

注意：博文没有分类的功能，取而代之的是`标签`，一篇博文**最多**可有`5个标签`。

- **<a id='all_article'>GET `/[your name]/articles`   获取博文列表或按`标签`名获取</a>**

    获取博文列表，分页的，结果也是结构化的。如果使用**angular-paginate**则使用`/[your name]/articles/anything`

    可以在参数中传入`tagname`，表示获取该标签下的博文。

    参数
    ```js
        {
            'start':[int],  //可选，默认：0。从某索引开始获取
            'end':[int],    //可选，默认：100。截止到某索引完毕，最多获取100条，超过则按end=start+100算
            'tagname':[string], //可选，若传入了标签名，则获取改标签下的博文
        }
    ```
    返回
    ```js
        {
            'data':[{                       //博文数组
                'id':[int],                 //博文id
                'title':[int],              //标题
                'content':[string],             //内容
                'views':[int],              //浏览次数
                'user_id':[int],            //作者id
                'created_at':[date],            //发表日期
                'comment_count':[int],      //评论个数
                'updated_at':[date],            //修改日期
                'user':{                        //作者实体
                    'id':[int],             //作者id
                    'username':[string],        //作者用户名
                    'name':[string]             //作者姓名
                },
                'tags':[{                       //标签数组
                    'title':[string]            //标签标题
                    }]
            }],
            'count':[int],                  //本次分页条数
            'start':[int],                  //从某索引开始
            'end':[int]                     //到某索引结束
        }
    ```

- **<a id='all_article'>GET `/[your name]/articles/anything`   获取博文列表或按`标签`名获取，配合angular-paginate-anything使用</a>**

    获取博文列表，分页的。配合**angular-paginate-anything**使用。

    可以在参数中传入`tagname`，表示获取该标签下的博文。

    参数
    ```js
        {
            'tagname':[string], //可选，若传入了标签名，则获取改标签下的博文
        }
    ```
    返回
    ```js
        {
            'data':[{                       //博文数组
                'id':[int],                 //博文id
                'title':[int],              //标题
                'content':[string],             //内容
                'views':[int],              //浏览次数
                'user_id':[int],            //作者id
                'created_at':[date],            //发表日期
                'comment_count':[int],      //评论个数
                'updated_at':[date],            //修改日期
                'user':{                        //作者实体
                    'id':[int],             //作者id
                    'username':[string],        //作者用户名
                    'name':[string]             //作者姓名
                },
                'tags':[{                       //标签数组
                    'title':[string]            //标签标题
                    }]
            }],
            'count':[int],                  //本次分页条数
            'start':[int],                  //从某索引开始
            'end':[int]                     //到某索引结束
        }
    ```

- **<a>POST `/[your name]/articles`  添加博文</a>**

    `需要登录`

    传入的标签是一个**字符串的数组**，如：['日志','转载']

    参数
    ```js
        {
            'title':[string]*,       //标题
            'tags':[Array:string]   //标签，数组，可选。用于分类，最多5个，操作则记录前5个
            'content':[string]*      //内容
        }
    ```
    返回
    ```js
        {
            'id':[int],                 //博文id
            'title':[int],              //标题
            'content':[string],             //内容
            'views':[int],              //浏览次数
            'user_id':[int],            //作者id
            'created_at':[date],            //发表日期
            'comment_count':[int],      //评论个数
            'updated_at':[date],            //修改日期
        }
    ```

- **<a>GET `/[your name]/articles/:id`   按id获取博文</a>**

    `:id`是博文的id

    返回
    ```js
        {
            'id':[int],                 //博文id
            'title':[int],              //标题
            'content':[string],             //内容
            'views':[int],              //浏览次数
            'user_id':[int],            //作者id
            'created_at':[date],            //发表日期
            'comment_count':[int],      //评论个数
            'updated_at':[date],            //修改日期
            'user':{                        //作者实体
                'id':[int],             //作者id
                'username':[string],        //作者用户名
                'name':[string]             //作者姓名
            },
            'tags':[{                       //标签数组
                'title':[string]            //标签标题
            }]
        }
    ```

- **<a>PUT `/[your name]/articles/:id`   按id修改博文内容</a>**

    `需要登录`

    `:id`是博文的id

    参数
    ```js
        {
            'title':[string]*        //博文标题
            'content':[string]*      //博文内容
        }
    ```
    返回
    ```js
        {
            'id':[int],                 //博文id
            'title':[int],              //标题
            'content':[string],             //内容
            'views':[int],              //浏览次数
            'user_id':[int],            //作者id
            'created_at':[date],            //发表日期
            'comment_count':[int],      //评论个数
            'updated_at':[date],            //修改日期
            'user':{                        //作者实体
                'id':[int],             //作者id
                'username':[string],        //作者用户名
                'name':[string]             //作者姓名
            },
            'tags':[{                       //标签数组
                `title`:[string]            //标签标题
            }]
        }
    ```

- **<a>DELETE `/[your name]/articles/:id`    按id删除博文</a>**

    `需要登录`

    `:id`是博文id

###Comments 评论

- **<a>GET `/[your name]/article/:id/comments`  按博文获取评论·分页</a>**

    参数
    ```js
        {
            'id':[int],      //博文id
            'start':[int],  //可选，默认：0。从某索引开始获取
            'end':[int],    //可选，默认：100。截止到某索引完毕，最多获取100条，超过则按end=start+100算
        }
    ```
    返回
    ```js
        {
            'data':[{                       //评论数组
                'id':[int],             //评论id
                'content':[string],         //评论内容
                'created_at':[date]         //评论时间
            }],
            'count':[int],                  //本次分页条数
            'start':[int],                  //从某索引开始
            'end':[int]                     //到某索引结束
        }
    ```

- **<a>GET `/[your name]/article/:id/comments/anything`  按博文获取评论，配合angular-paginate-anything使用</a>**

    `:id`是博文id

    返回
    ```js
        {
            'data':[{                       //评论数组
                'id':[int],             //评论id
                'content':[string],         //评论内容
                'created_at':[date]         //评论时间
            }],
            'count':[int],                  //本次分页条数
            'start':[int],                  //从某索引开始
            'end':[int]                     //到某索引结束
        }
    ```

- **<a>POST `/[your name]/article/:id/comments` 给某博文添加一条评论

    `:id`是博文id

    评论只需要传入**内容**即可，评论人是按当前登录人获取的。比如，A在B博客里评论，则记录的是A的名字。若没有登录则是匿名。

    参数
    ```js
        {
            'content':[string]  //内容
        }
    ```

    返回
    ```js
        {
            'id':[int],             //评论id
            'content':[string],     //内容
            'layer':[int],          //第N楼
            'name':[string],        //评论人名
            'ip':[string]           //评论所属ip
        }
    ```