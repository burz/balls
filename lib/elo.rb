module Elo
  K = 48
  I_W = 5
  def calculate_rankings winners, losers, cups_left, cups_per_team
    cup_factor = cups_per_team / 2
    puts cup_factor
    k_c_l = K * Math.exp((cups_left - cup_factor) / 2.5)
    winner_average_rating = team_average winners
    loser_average_rating = team_average losers
    winner_tdiff = loser_average_rating - winner_average_rating
    loser_tdiff = winner_average_rating - loser_average_rating
    winner_ratings = winners.map do |winner|
      pdiff = winner_average_rating - winner
      factor = 1 + calculate_term(pdiff, winner_tdiff)
      (k_c_l * factor + winner).to_i
    end
    loser_ratings = losers.map do |loser|
      pdiff = loser_average_rating - loser.rating
      factor = 1 + calculate_term(pdiff, loser_tdiff)
      (k_c_l * factor + winner).to_i
    end
    { winner_ratings: winner_ratings, loser_ratings: loser_ratings }
  end
  def team_average team
    team.inject { |sum, player| sum + player } / team.size
  end
  def calculate_term pdiff, tdiff
    (I_W + 1) / (I_W + 10 ** (pdiff / 400)) - 1 / (1 + 10 ** (tdiff / 400)) - 1
  end
end
