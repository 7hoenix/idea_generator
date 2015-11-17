class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.integer :possibility_alpha_id
      t.integer :possibility_beta_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
