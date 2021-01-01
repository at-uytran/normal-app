require "aws-sdk"

unless Settings.aws_envs.include? Rails.env
  Aws.config.update({
    region: ENV["AWS_REGION"],
    credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
  })
end
