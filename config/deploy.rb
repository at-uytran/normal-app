# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "normal-app"
set :repo_url, "git@github.com:at-uytran/normal-app.git"

set :bundle_binstubs, nil

set :deploy_to, "/var/www/html/#{fetch(:application)}"

set :linked_files, fetch(:linked_files, [])
  .push("config/database.yml", "config/secrets.yml")

set :linked_dirs, fetch(:linked_dirs, [])
  .push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor/bundle",
    "public/uploads", "public/assets")

set :keep_releases, 5

after "deploy:publishing", "deploy:restart"

namespace :deploy do
  task :restart do
    invoke "unicorn:restart"
  end
end
namespace :deploy do
  task :add_default_hooks do
    after 'deploy:starting', 'sidekiq:quiet'
    after 'deploy:updated', 'sidekiq:stop'
    after 'deploy:reverted', 'sidekiq:stop'
    after 'deploy:published', 'sidekiq:start'
  end
end

