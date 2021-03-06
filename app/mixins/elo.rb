module Elo
  K = 48.0
  I_W = 5.0
  def calculate_rankings winners, losers, cups_left, cups_per_team
    cup_factor = 10.0
    k_c_l = K * Math.exp((cups_left - cup_factor) / 2.5)
    winner_average_rating = team_average winners
    loser_average_rating = team_average losers
    winner_tdiff = loser_average_rating - winner_average_rating
    winner_ratings = winners.map do |winner|
      pdiff = winner_average_rating - winner.rating
      factor = 1.0 + calculate_term(pdiff, winner_tdiff)
      (k_c_l * factor + winner.rating).to_i
    end
    loser_tdiff = winner_average_rating - loser_average_rating
    loser_ratings = losers.map do |loser|
      pdiff = loser_average_rating - loser.rating
      factor = calculate_term(pdiff, loser_tdiff)
      (k_c_l * factor + loser.rating).to_i
    end
    { winner_ratings: winner_ratings, loser_ratings: loser_ratings }
  end
  def team_average team
    team.inject(0.0) { |sum, player| sum + player.rating } / team.size
  end
  def calculate_term pdiff, tdiff
    (I_W + 1.0) / (I_W + 10.0 ** (pdiff / 400.0)) -
    1.0 / (1.0 + 10.0 ** (tdiff / 400.0)) - 1.0
  end
end
