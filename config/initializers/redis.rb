if ENV['REDISTOGO_URL']
  uri = URI.parse ENV['REDISTOGO_URL']
  REDIS = Redis.new url: uri
else
  REDIS = Redis.new host: 'localhost', port: 6379
end
