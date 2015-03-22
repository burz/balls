class CreateLeagueRatings < ActiveRecord::Migration
  def change
    create_table :league_ratings do |t|
      t.belongs_to :user
      t.belongs_to :league
      t.integer :rating
      t.integer :games_played
      t.integer :wins
      t.integer :losses

      t.timestamps null: false
    end
  end
end
