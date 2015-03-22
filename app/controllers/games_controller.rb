class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
    @leagues = current_user.leagues
    @game = Game.find params[:id]
  end

  def create
    game = Game.create game_params
    season = Season.find params[:season_id]
    league = season.league
    winners = params[:game][:winners]
    losers = params[:game][:losers]
    winner_starting_season_ratings = []
    winning_season_players = []
    winner_starting_league_ratings = []
    winning_league_players = []
    winners.map! do |winner_id|
      winner = User.find winner_id
      season_rating = season.user_rating winner
      winning_season_players.push Elo::Player.new rating: season_rating.rating
      winner_starting_season_ratings.push season_rating
      league_rating = league.user_rating winner
      winning_league_players.push Elo::Player.new rating: league_rating.rating
      winner_starting_league_ratings.push league_rating
      winner
    end
    loser_starting_season_ratings = []
    losing_season_players = []
    loser_starting_league_ratings = []
    losing_league_players = []
    losers.map! do |loser_id|
      loser = User.find loser_id
      season_rating = season.user_rating loser
      losing_season_players.push Elo::Player.new rating: season_rating.rating
      loser_starting_season_ratings.push season_rating
      league_rating = season.user_rating loser
      losing_league_players.push Elo::Player.new rating: league_rating.rating
      loser_starting_league_ratings.push league_rating
      loser
    end
    winning_season_players.each_with_index do |winner, i|
      losing_season_players.each_with_index do |loser, j|
        winner.wins_from loser
        winning_league_players[i].wins_from losing_league_players[j]
      end
      SeasonRating.create user: winners[i], season: season, rating: winner.rating,
                          games: winner_starting_season_ratings[i].games + 1,
                          wins: winner_starting_season_ratings[i].wins + 1,
                          losses: winner_starting_season_ratings[i].losses
      LeagueRating.create user: winners[i], league: league,
                          rating: winning_league_players[i].rating,
                          games: winner_starting_league_ratings[i].games + 1,
                          wins: winner_starting_league_ratings[i].wins + 1,
                          losses: winner_starting_league_ratings[i].losses
      change_in_season_rating = winner.rating - winner_starting_season_ratings[i].rating
      change_in_league_rating = winning_league_players[i].rating -
                                winner_starting_season_ratings[i].rating
      Player.create game: game, user: winners[i], team: 0,
                    change_in_season_rating: change_in_season_rating,
                    change_in_league_rating: change_in_league_rating
    end
    losing_season_players.each_with_index do |loser, i|
      SeasonRating.create user: losers[i], season: season, rating: loser.rating,
                          games: loser_starting_season_ratings[i].games + 1,
                          wins: loser_starting_season_ratings[i].wins,
                          losses: loser_starting_season_ratings[i].losses + 1
      LeagueRating.create user: losers[i], league: league,
                          rating: losing_league_players[i].rating,
                          games: loser_starting_league_ratings[i].games + 1,
                          wins: loser_starting_league_ratings[i].wins,
                          losses: loser_starting_league_ratings[i].losses + 1
      change_in_season_rating = loser.rating - loser_starting_season_ratings[i].rating
      change_in_league_rating = losing_league_players[i].rating -
                                loser_starting_league_ratings[i].rating
      Player.create game: game, user: losers[i], team: 1,
                    change_in_season_rating: change_in_season_rating,
                    change_in_league_rating: change_in_league_rating
    end
    render nothing: true
  end

  def game_params
    new_params = params.require(:game).permit :cup_differential
    new_params[:season_id] = params[:season_id]
    new_params
  end
end
