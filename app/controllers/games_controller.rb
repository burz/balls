class GamesController < ApplicationController
  include Elo

  before_action :authenticate_user!
  before_action :load_leagues_and_seasons, only: [:show]

  def show
    @leagues = current_user.leagues
    @game = Game.find params[:id]
  end

  def create
    game = Game.create game_params
    season = Season.find params[:season_id]
    league = season.league
    winner_league_ratings = []
    winner_season_ratings = []
    winners = params[:game][:winners].map do |winner_id|
      winner = User.find winner_id
      league_rating = league.user_rating winner
      winner_league_ratings.push league_rating
      season_rating = season.user_rating winner
      winner_season_ratings.push season_rating
      winner
    end
    loser_league_ratings = []
    loser_season_ratings = []
    losers = params[:game][:losers].map do |loser_id|
      loser = User.find loser_id
      league_rating = league.user_rating loser
      loser_league_ratings.push league_rating
      season_rating = season.user_rating loser
      loser_season_ratings.push season_rating
      loser
    end
    league_result = calculate_rankings winner_league_ratings,
                                       loser_league_ratings,
                                       params[:game][:cup_differential].to_i,
                                       season.cups_per_team
    season_result = calculate_rankings winner_season_ratings,
                                       loser_season_ratings,
                                       params[:game][:cup_differential].to_i,
                                       season.cups_per_team
    winners.each_with_index do |winner, i|
      league_rating = league_result[:winner_ratings][i]
      LeagueRating.create user: winner, league: league, rating: league_rating,
                          games_played: winner_league_ratings[i].games_played + 1,
                          wins: winner_league_ratings[i].wins + 1,
                          losses: winner_league_ratings[i].losses
      season_rating = season_result[:winner_ratings][i]
      SeasonRating.create user: winner, season: season, rating: season_rating,
                          games_played: winner_season_ratings[i].games_played + 1,
                          wins: winner_season_ratings[i].wins + 1,
                          losses: winner_season_ratings[i].losses
      change_in_league_rating = league_rating - winner_league_ratings[i].rating
      change_in_season_rating = season_rating - winner_season_ratings[i].rating
      Player.create game: game, user: winner, team: 0,
                    change_in_league_rating: change_in_league_rating,
                    change_in_season_rating: change_in_season_rating
    end
    losers.each_with_index do |loser, i|
      league_rating = league_result[:loser_ratings][i]
      LeagueRating.create user: loser, league: league, rating: league_rating,
                          games_played: loser_league_ratings[i].games_played + 1,
                          wins: loser_league_ratings[i].wins,
                          losses: loser_league_ratings[i].losses + 1
      season_rating = season_result[:loser_ratings][i]
      SeasonRating.create user: loser, season: season, rating: season_rating,
                          games_played: loser_season_ratings[i].games_played + 1,
                          wins: loser_season_ratings[i].wins,
                          losses: loser_season_ratings[i].losses + 1
      change_in_league_rating = league_rating - loser_league_ratings[i].rating
      change_in_season_rating = season_rating - loser_season_ratings[i].rating
      Player.create game: game, user: loser, team: 1,
                    change_in_league_rating: change_in_league_rating,
                    change_in_season_rating: change_in_season_rating
    end
    render json: { game_id: game.id }
  end

  def game_params
    new_params = params.require(:game).permit :cup_differential
    new_params[:season_id] = params[:season_id]
    new_params
  end
end
