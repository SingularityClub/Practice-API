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
- 文章评论
- 第三方登录**（如：微博、微信，开发中）

##API Document

- Users
    - POST  `/api/users` 添加用户

    ```
        参数:
            username:string 用户名
            password:string 密码
            [gender:Integer [0:未知(default)，1:男，2:女]] 性别
            
        返回：
            用户实体
    ```


    - POST  `/api/users/login`   登录
    ```
        参数：
            username:string 用户名
            password:string 密码
            
        返回：
            用户实体
    ```
    
    - POST  `/api/users/logout`  注销
    ```
        无参数
        无返回
    ```
    
    - GET   `/api/users/current`  获取当前登录用户
    ```
        返回：
            用户实体
    ```
    
    - GET   `/api/users/:id`    获取特定id的用户
    ```
        参数：
            id:integer   用户id 
            
        返回：
            用户实体
    ```

    - PUT   `/api/users/:id`    修改某特定id的用户
    ```
        参数：
            id:integer  用户id
            [name:string]   用户真实姓名
            [email:string]  电子邮件地址
            [password:string]   密码
            [gender:integer]    性别
        
        返回：
            用户实体
    ```
    
    - DELETE `api/users/:id`    删除某用户
    ```
        参数：
            id:integer 用户id
    ```
    
    
    
