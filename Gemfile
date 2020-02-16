source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.7"
gem "mysql2"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "warden"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "redis", "~> 3.0"
gem "bcrypt", "~> 3.1.7"
gem "config"
gem "rack-cors"
gem "unicorn"
gem "paranoia"
gem "carrierwave"
gem "sidekiq"
gem "sidekiq-status"
gem "carrierwave-video-thumbnailer"
gem "ransack"
gem "kaminari"
gem "capistrano-sidekiq"
gem "dotenv-rails"

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "pry-rails"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
end

group :development do
  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano3-unicorn"
  gem "capistrano-rvm"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
