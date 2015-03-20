class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :cup_differential

      t.timestamps null: false
    end
  end
end
