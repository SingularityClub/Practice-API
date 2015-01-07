class Etrain::ArticleApi < Grape::API
  resources :articles do
    helpers ::ToolKit

    desc '获取文章列表'
    get do
      articles= paginate_anything do |start, _end|
        if params[:tagname]
          Article.pagenate_for_tag(params[:tagname], start, _end)
        else
          Article.paginate(start, _end)
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
      after_validation do
        @article = Article.find_by(id: params[:id])
      end
      get do
        return status(404) unless @article

        @article.views+=1
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
            paginate_anything do |start, _end|
              @article.paginate_comments(start, _end)
                  .as_json(only: [:o_auth_account_id, :id, :content, :up, :down, :created_at],
                           include: {o_auth_account: {only: [:id, :avatar_large, :screen_name]}})
            end
          else
            status(404)
          end
        end

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
          delete do
            require_authorized!

            @comment.destroy!
          end

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