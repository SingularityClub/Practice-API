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

- **以下API文档**

### **Users 用户** <span id='users'></span>
- **<a id="user_all">GET `/[your name]/users`    获取所有用户<a>**

    `需要管理员权限`，请忽略此API

    返回：
    ```javascript
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

    参数：
    ```javascript
        {
            'username':[string],
            'password':[string],
            'gender':[int]        //可选。0:未知，1:男，2:女
        }
    ```
    返回：
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
            'id':[int],     //id
            'username':[string],//用户名
            'name':[string],    //真实姓名
            'email':[string],   //电子邮件
            'gender':[int]  //性别
        }
    ```

- **<a id="logout">POST `/[your name]/users/logout`    注销</a>**
    >   清除cookie

- **<a id="current_user">GET `/[your name]/users/current`    获取当前登录用户</a>**

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

    参数
    ```js
        {
            'id':[int],         //用户id
            'old_password':[string] //旧密码
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

    参数
    ```js
        {
            'id':[int],         //用户id
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

    参数
    ```js
        {
            'id':[int]  //用户id
        }
    ```


### **Article   文章**

- **<a>GET `/[your name]/articles`   获取文章列表或按标签名获取</a>**

    参数
    ```js
        {
            'start':[int],  //可选，默认：0。从某索引开始获取
            'end':[int],    //可选，默认：100。截止到某索引完毕，最多获取100条，超过则按end=start+100算
            'tagname':[string], //可选，若传入了标签名，则获取改标签下的文章
        }
    ```
    返回
    ```js
        {
            'data':[{                       //文章数组
                'id':[int],                 //文章id
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

- **<a>POST `/[your name]/articles`  添加文章</a>**

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
            'id':[int],                 //文章id
            'title':[int],              //标题
            'content':[string],             //内容
            'views':[int],              //浏览次数
            'user_id':[int],            //作者id
            'created_at':[date],            //发表日期
            'comment_count':[int],      //评论个数
            'updated_at':[date],            //修改日期
        }
    ```

- **<a>GET '/[your name]/articles/:id'   按id获取文章</a>**

    参数
    ```js
        {
            'id':[int]  //文章id
        }
    ```
    返回
    ```js
        {
            'id':[int],                 //文章id
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

- **<a>PUT `/[your name]/articles/:id`   按id修改文章内容</a>**

    参数
    ```js
        {
            'contnet':[string]      //文章内容
        }
    ```
    返回
    ```js
        {
            'id':[int],                 //文章id
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

- **<a>DELETE `/[your name]/articles/:id`    按id删除文章</a>**

    参数
    ```js
        {
            'id':[int]  //文章id
        }
    ```

###Comments 评论

- **<a>GET `/[your name]/article/:id/comments`  按文章获取评论·分页</a>**

    参数
    ```js
        {
            'id':[int],      //文章id
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
