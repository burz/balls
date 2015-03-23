json.array! @seasons do |season|
  json.extract! season, :id, :name, :players_per_team, :cups_per_team
end
