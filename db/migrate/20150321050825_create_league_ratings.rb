class CreateLeagueRatings < ActiveRecord::Migration
  def change
    create_table :league_ratings do |t|
      t.belongs_to :league_membership
      t.integer :rating

      t.timestamps null: false
    end
  end
end
