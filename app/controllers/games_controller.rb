class GamesController < ApplicationController
  def create
    game = Game.create game_params
    winners = params[:game][:winners]
    winners.each do |winner_id|
      Player.create game_id: game.id, user_id: winner_id, team: 0
    end
    losers = params[:game][:losers]
    losers.each do |loser_id|
      Player.create game_id: game.id, user_id: loser_id, team: 1
    end
    render nothing: true
  end

  def game_params
    new_params = params.require(:game).permit :cup_differential
    new_params[:season_id] = params[:season_id]
    new_params
  end
end
