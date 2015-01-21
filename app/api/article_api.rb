class PracticeAPI::ArticleApi < Grape::API
  resources :articles do
    helpers ::ToolKit

    desc '获取文章列表'
    get do
      start = params[:start]||0
      _end = params[:end]||100
      if params[:tagname]
        user_id = @space_user.id #解决proc的上下文问题
        articles, count=Article.paginate_for_tag(params[:tagname], -> { where user_id: user_id }, start, _end)
      else
        articles, count=Article.paginate(@space_user.available_articles, start, _end)
      end

      paginate_result articles.as_json(include: {tags: {only: :title}, user: {only: [:id, :username, :name]}}), count, start
    end

    desc '用paginate_anything获取文章列表'
    get :anything do
      articles= paginate_anything do |start, _end|
        if params[:tagname]
          user_id = @space_user.id #解决proc的上下文问题
          Article.paginate_for_tag(params[:tagname], -> { where(user_id: user_id) }, start, _end)
        else
          Article.paginate(@space_user.available_articles, start, _end)
        end
      end
      articles.as_json(include: {tags: {only: :title}, user: {only: [:id, :username, :name]}})
    end

    desc '添加文章'
    params do
      requires :title, type: String
      requires :tags, type: Array
      requires :content, type: String
    end
    post do
      require_authorized!

      Article.post params[:title], params[:content], params[:tags], @current_user.id
    end

    params do
      requires :id, type: Integer
    end
    namespace ':id' do
      helpers ::ToolKit
      after_validation do
        @article = Article.find_by(id: params[:id])
      end

      desc '获取某文章，并且让浏览数+1'
      get do
        error!({message: '此博文不存在！'}.as_json, 404) unless @article

        @article.views+=1
        @article.save!
        @article.safe_attributes
      end

      desc '修改文章内容'
      params do
        requires :title, type: String
        requires :content, type: String
      end
      post do
        require_authorized!

        @article.content = params[:content]
        @article.title = params[:title]
        @article.save!
        @article.safe_attributes
      end

      desc '禁用某文章'
      delete do
        require_authorized!

        @article.enable = false
        @article.save!
      end

      namespace 'comments' do
        helpers ::ToolKit
        after_validation do
          @article = Article.find_by(id: params[:id])
        end

        desc '获取带文章的所有评论'
        get do
          error!({message: '不存在此博文！'}.as_json, 404) unless @article

          start = params[:start]
          _end = params[:end]
          comments, count = @article.paginate_comments(start, _end)
                                .as_json(only: [:id, :content, :up, :down, :created_at, :layer, :name, :enable])
          paginate_result comments, count
        end

        desc '用控件获取评论'
        get :anything do
          error!({message: '不存在此博文！'}.as_json, 404) unless @article

          paginate_anything do |start, _end|
            @article.paginate_comments(start, _end)
                .as_json(only: [:id, :content, :up, :down, :created_at, :layer, :name, :enable])
          end
        end

        desc '添加一条评论'
        params do
          requires :content, type: String
        end
        post do
          Comment.post(@article, params[:content], @current_user)
        end

        params do
          requires :comment_id, type: Integer
        end
        namespace ':comment_id' do
          helpers ::ToolKit
          after_validation do
            @comment = Comment.find_by(id: params[:comment_id])
          end

          desc '删除该评论'
          delete do
            require_authorized!

            @comment.disable!
          end
        end
      end
    end
  end
end