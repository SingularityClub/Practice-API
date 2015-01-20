class PracticeAPI::ArticleApi < Grape::API
  resources :articles do
    helpers ::ToolKit

    desc '获取文章列表'
    get do
      start = params[:start]||0
      _end = params[:end]||100
      if params[:tagname]
        articles, count=Article.paginate_for_tag(params[:tagname], start, _end)
      else
        articles, count=Article.paginate(start, _end)
      end

      paginate_result articles.as_json(include: {tags: {only: :title}, user: {only: [:id, :username, :name]}}), count, start
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
      after_validation do
        @article = Article.find_by(id: params[:id])
      end

      desc '获取某文章，并且让浏览数+1'
      get do
        return status(404) unless @article

        @article.views+=1
        @article.save!
        @article.safe_attributes
      end

      desc '修改文章内容'
      params do
        requires :content, type: String
      end
      put do
        require_authorized!

        @article.content = params[:content]
        @article.save!
        @article.safe_attributes
      end

      desc '禁用某文章'
      delete do
        require_authorized!

        @article.enable = false
        @article.save!
      end

      desc '获取带文章的所有评论'
      namespace 'comments' do
        get do
          if @article
            start = params[:start]
            _end = params[:end]
            comments, count = @article.paginate_comments(start, _end)
                                  .as_json(only: [:o_auth_account_id, :id, :content, :up, :down, :created_at],
                                           include: {o_auth_account: {only: [:id, :avatar_large, :screen_name]}})
            paginate_result comments, count
          else
            status(404)
          end
        end

        desc '添加一条评论'
        params do
          requires :content, type: String
          optional :account, type: Hash do
            optional :id, type: String
            optional :screen_name, type: String
          end
          optional :parent_id, type: Integer
        end
        post do
          Comment.post(@article, params[:content], params[:parent_id], params[:account])
        end

        params do
          requires :comment_id, type: Integer
        end
        namespace ':comment_id' do
          after_validation do
            @comment = Comment.find_by(id: params[:comment_id], enable: true)
          end

          desc '删除该评论'
          delete do
            require_authorized!

            @comment.destroy!
          end

          desc '禁用该评论'
          put do
            require_authorized!

            @comment.enable = false
            @comment.save!
          end
        end
      end
    end
  end
end