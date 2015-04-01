CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV['AWS_BUCKET_NAME']
  config.aws_acl    = :public_read
  config.asset_host = 'http://s3-us-west-2.amazonaws.com/ballsapp-avatars'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     ENV['AWS_SECRET_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
end
