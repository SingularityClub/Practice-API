class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content, limit: 6000, null: false
      t.integer :up, default: 0, null: false
      t.integer :down, default: 0, null: false
      t.boolean :enable, default: true, null: false
      t.integer :layer, null: false
      t.string :name
      t.string :ip

      t.references :article, index: true
      t.timestamps
    end
  end
end
