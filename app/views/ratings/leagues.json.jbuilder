json.array! @user_leagues do |league|
  json.extract! league, :name, :created_at
  league_ratings = league.user_ratings @user
  json.set! :data do
    json.array! league_ratings do |rating|
      json.extract! rating, :created_at
      json.set! :value, rating.rating
    end
  end
end
