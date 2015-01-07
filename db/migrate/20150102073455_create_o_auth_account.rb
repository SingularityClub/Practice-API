class CreateOAuthAccount < ActiveRecord::Migration
  def change
    create_table :o_auth_accounts do |t|
      t.string :idstr
      t.string :screen_name
      t.string :name
      t.string :url
      t.string :profile_image_url
      t.string :gender
      t.string :avatar_large
      t.string :avatar_hd
      t.string :lang

      t.references :user, null: true

      t.timestamps
    end
  end
end
