CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => ENV['PICTGUR_AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key => ENV['PICTGUR_AWS_SECRET_ACCESS_KEY'],
    :region => ENV['PICTGUR_AWS_REGION']
  }

  config.fog_directory = ENV['PICTGUR_AWS_BUCKET']
end