module RetroactiveRatings
  include Constants
  include Elo

  def fix_ratings
    puts 'Fixing ratings...'
    LeagueRating.all.each { |rating| rating.destroy }
    SeasonRating.all.each { |rating| rating.destroy }
    User.all.each do |user|
      user.leagues.each do |league|
        rating = LeagueRating.create user: user, league: league, rating: LEAGUE_START,
                                     games_played: 0, wins: 0, losses: 0
        rating.created_at = league.created_at
        rating.save
      end
      user.seasons.each do |season|
        rating = SeasonRating.create user: user, season: season, rating: SEASON_START,
                                     games_played: 0, wins: 0, losses: 0
        rating.created_at = season.created_at
        rating.save
      end
    end
    Game.order(created_at: :asc).each do |game|
      update_game_ratings game
    end
    puts 'Done fixing ratings.'
  end

  protected

  def update_game_ratings game
    puts('Updating ratings for game ' + game.id.to_s)
    season = game.season
    league = season.league
    winners = []
    winner_league_ratings = []
    winner_season_ratings = []
    losers = []
    loser_league_ratings = []
    loser_season_ratings = []
    game.players.each do |player|
      if player.team == 0
        winner = player.user
        winners.push winner
        league_rating = league.user_rating winner
        winner_league_ratings.push league_rating
        season_rating = season.user_rating winner
        winner_season_ratings.push season_rating
      else
        loser = player.user
        losers.push loser
        league_rating = league.user_rating loser
        loser_league_ratings.push league_rating
        season_rating = season.user_rating loser
        loser_season_ratings.push season_rating
      end
      player.destroy
    end
    league_result = calculate_rankings winner_league_ratings,
                                       loser_league_ratings,
                                       game.cup_differential,
                                       season.cups_per_team
    season_result = calculate_rankings winner_season_ratings,
                                       loser_season_ratings,
                                       game.cup_differential,
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
    puts 'Done updating game ratings'
  end
end
