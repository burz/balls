class GamesController < ApplicationController
  def create
    game_params = params[:game]
    winners = game_params[:winners]
    losers = game_params[:losers]
    game = Game.create cup_differential: game_params[:cup_diffential]
    winners.each do |winner_id|
      Player.create game_id: game.id, user_id: winner_id, team: 0
    end
    losers.each do |loser_id|
      Player.create game_id: game.id, user_id: loser_id, team: 1
    end
    render nothing: true
  end
end
