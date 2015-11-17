class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :list_type
      t.integer :user_id
      t.integer :possibility_id

      t.timestamps null: false
    end
  end
end
