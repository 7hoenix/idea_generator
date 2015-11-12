class CreatePossibilities < ActiveRecord::Migration
  def change
    create_table :possibilities do |t|
      t.string :title
      t.string :source

      t.timestamps null: false
    end
  end
end
