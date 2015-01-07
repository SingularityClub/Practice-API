class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content
      t.integer :views, null: false, default: 0
      t.boolean :enable, default: true, null: false
      t.integer :comment_count, default: 0, null: false
      
      t.references :user, index: true

      t.timestamps
    end
  end
end
