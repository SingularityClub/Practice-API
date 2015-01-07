class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :o_auth_account

  class << self
    def post(article, content, parent_id, account)
      Comment.transaction do
        _account = OAuthAccount.update_from_web account
        p _account.as_json
        Comment.create! article_id: article.id, content: content, comment_id: parent_id, o_auth_account_id: (_account.id if _account)

        article.comment_count+=1
        article.save!
      end
    end
  end
end