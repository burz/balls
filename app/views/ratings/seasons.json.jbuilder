json.array! @user_seasons do |season|
  json.extract! season, :name, :created_at
  season_ratings = season.user_ratings current_user
  json.set! :data do
    json.array! season_ratings do |rating|
      json.extract! rating, :created_at
      json.set! :value, rating.rating
    end
  end
end
