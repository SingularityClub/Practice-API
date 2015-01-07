class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, limit: 32
      t.string :name
      t.string :encrypted_password, null: false
      t.string :email
      t.string :salt, null: false
      t.integer :gender, default: 0
      t.boolean :enable, default: true, null: false

      t.references :o_auth_account, index: true, null: true
      t.timestamps
    end
  end
end
