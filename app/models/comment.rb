class Comment < ActiveRecord::Base
  belongs_to :article

  class << self
    def post(article, content)
      Comment.transaction do
        Comment.create! article_id: article.id, content: content, layer: article.all_comments.count

        article.comment_count+=1
        article.save!
      end
    end
  end
end