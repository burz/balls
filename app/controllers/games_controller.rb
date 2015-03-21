class GamesController < ApplicationController
  def create
    game = Game.create game_params
    season = Season.find params[:season_id]
    winners = params[:game][:winners]
    losers = params[:game][:losers]
    winner_starting_season_ratings = []
    winning_season_players = []
    winners.map! do |winner_id|
      winner = User.find winner_id
      rating = season.user_rating winner
      winning_season_players.push Elo::Player.new rating: rating
      winner_starting_season_ratings.push rating
      winner
    end
    loser_starting_season_ratings = []
    losing_season_players = []
    losers.map! do |loser_id|
      loser = User.find loser_id
      rating = season.user_rating loser
      losing_season_players.push Elo::Player.new rating: rating
      loser_starting_season_ratings.push(season.user_rating loser)
      loser
    end
    winning_season_players.each_with_index do |winner, i|
      losing_season_players.each do |loser|
        winner.wins_from loser
      end
      change_in_rating = winner.rating - winner_starting_season_ratings[i]
      puts winner.rating
      SeasonRating.create user: winners[i], season: season, rating: winner.rating
      Player.create game: game, user: winners[i], team: 0,
                    change_in_rating: change_in_rating
    end
    losing_season_players.each_with_index do |loser, i|
      change_in_rating = loser.rating - loser_starting_season_ratings[i]
      puts loser.rating
      SeasonRating.create user: losers[i], season: season, rating: loser.rating
      Player.create game: game, user: losers[i], team: 1,
                    change_in_rating: change_in_rating
    end
    render nothing: true
  end

  def game_params
    new_params = params.require(:game).permit :cup_differential
    new_params[:season_id] = params[:season_id]
    new_params
  end
end
