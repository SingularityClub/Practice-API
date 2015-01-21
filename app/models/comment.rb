class Comment < ActiveRecord::Base
  belongs_to :article

  validates :content,
            length: {in: 1...6000, message: '内容不能为空并且应小于6000个字符！'}

  def disable!
    self.enable = false
    self.name = '已删除'
    self.content = '该评论已被管理员删除！'
    self.save!
  end

  class << self
    def post(article, content, current_user)
      Comment.transaction do
        Comment.create! article_id: article.id, content: content, layer: article.all_comments.count+1,
                        name: (current_user.name || current_user.username if current_user)

        article.comment_count+=1
        article.save!
      end
    end
  end
end