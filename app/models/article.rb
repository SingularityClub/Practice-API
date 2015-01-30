class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags, class_name: 'Tag'
  has_many :comments, -> { where enable: true }
  has_many :all_comments, class_name: 'Comment', foreign_key: 'article_id', dependent: :destroy

  def safe_attributes
    self.as_json(only: [:id, :title, :content, :views, :user, :created_at, :updated_at, :comment_count],
                 include: {user: {only: [:id, :name, :username]}, tags: {only: :title}})
  end

  def paginate_comments(start=0, _end =100)
    start||=0
    _end||=100
    length = _end - start
    length = 100 if length>100
    return self.comments.offset(start).limit(length+1), self.comments.count
  end

  class << self
    def available
      Article.where(enable: true)
    end

    def paginate(article_source, start=0, _end=100)
      start||=0
      _end||=100
      length = _end - start
      length = 100 if length>100
      return article_source.includes(:user, :tags).select(:id, :title, :content, :views, :user_id, :created_at, :comment_count, :updated_at)
                 .order(created_at: :desc).offset(start).limit(length+1), article_source.count
    end

    def paginate_for_tag(tag_name, article_scope, start=0, _end=100)
      length = _end - start
      length = 100 if length>100
      tag = Tag.find_by(title: tag_name)
      raise '没有改标签' unless tag
      return tag.articles.instance_exec(&article_scope).select(:id, :title, :content, :views, :user_id, :created_at, :comment_count, :updated_at)
                 .order(created_at: :desc).offset(start).limit(length+1), tag.articles.count
    end

    def post(title, content, tags=[], user_id)
      tags_= Tag.add_mul_increment(tags||[])
      article = Article.create! title: title, content: content, user_id: user_id
      article.tags << tags_
      article
    end
  end
end