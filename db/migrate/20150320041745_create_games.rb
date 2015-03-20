class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :cup_differential
      t.belongs_to :season

      t.timestamps null: false
    end
  end
end
