CarrierWave.configure do |config|
  if Settings.aws_envs.include?(Rails.env)
    config.storage = :aws
    config.aws_bucket = ENV["BUCKET_NAME"]

    config.asset_host = ENV["CLOUD_FRONT_HOST"]

    # Optional: Signing of download urls,
    # e.g. for serving private content through CloudFront.
    # config.aws_signer = ->unsigned_url, options do
    #   Aws::CF::Signer.sign_url unsigned_url.dup, options
    # end
  else
    storage :file
  end
end
