require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module NormalApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += %W(#{config.root}/config/routes)
    config.time_zone = "Hanoi"
    config.generators.system_tests = nil
    config.eager_load_paths << Rails.root.join("lib")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_job.queue_adapter = :sidekiq

    Warden::Manager.serialize_into_session do |account|
      Application.set_account_into_session account
    end

    Warden::Manager.serialize_from_session do |session_info|
      Application.get_account_from_session session_info, Account
    end

    Warden::Manager.serialize_into_session(:admin) do |admin|
      Application.set_account_into_session admin
    end

    Warden::Manager.serialize_from_session(:admin) do |session_info|
      Application.get_account_from_session session_info, Admin
    end

    Warden::Manager.serialize_into_session(:user) do |user|
      Application.set_account_into_session user
    end

    Warden::Manager.serialize_from_session(:user) do |session_info|
      Application.get_account_from_session session_info, User
    end

    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.default_strategies :admin_login, :user_login
      manager.default_scope = :account
      manager.scope_defaults :admin, strategies: :admin_login
      manager.scope_defaults :user, strategies: :user_login
    end

    def get_account_from_session session_info, klass
      return unless session_info.is_a?(Array)
      object = klass.find_by(id: session_info.first)
      object if object && object.authenticateable_salt == session_info.last
    end

    def set_account_into_session account
      [account.id, account.authenticateable_salt]
    end
  end
end

