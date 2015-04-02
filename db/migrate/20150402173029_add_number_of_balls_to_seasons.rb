class AddNumberOfBallsToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :number_of_balls, :integer, default: 1
  end
end
