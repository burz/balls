class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :time
      t.integer :cup_differential

      t.timestamps null: false
    end
  end
end
