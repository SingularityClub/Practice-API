class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 32
      t.string :name
      t.string :encrypted_password, null: false
      t.string :email
      t.string :salt, null: false
      t.integer :gender, default: 0
      t.boolean :admin, null: false, default: false
      t.boolean :enable, default: true, null: false

      t.timestamps
    end
  end
end
