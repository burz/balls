class ChangeSeasonBallsDefault < ActiveRecord::Migration
  def change
    change_column_default :seasons, :number_of_balls, nil
  end
end
