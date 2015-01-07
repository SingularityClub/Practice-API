class CreateArticlesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :articles_tags, id: false do |t|
      t.integer :article_id, null: false, index: true
      t.integer :tag_id, null: false, index: true
    end
  end
end
