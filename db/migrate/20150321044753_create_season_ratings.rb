class CreateSeasonRatings < ActiveRecord::Migration
  def change
    create_table :season_ratings do |t|
      t.belongs_to :user
      t.belongs_to :season
      t.integer :rating
      t.integer :games
      t.integer :wins
      t.integer :losses

      t.timestamps null: false
    end
  end
end
