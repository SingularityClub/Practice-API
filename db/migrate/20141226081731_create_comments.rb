class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content, limit: 6000, null: false
      t.integer :up, default: 0, null: false
      t.integer :down, default: 0, null: false
      t.boolean :enable, default: true, null: false
      t.string :ip

      t.references :o_auth_account, index: true, null: true
      t.references :comment, index: true
      t.references :article, index: true

      t.timestamps
    end
  end
end
