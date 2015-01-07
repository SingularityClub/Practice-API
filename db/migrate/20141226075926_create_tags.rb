class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title, null: false, index: true
      t.string :icon
      t.boolean :enable, null: false, default: true

      t.timestamps
    end
  end
end
