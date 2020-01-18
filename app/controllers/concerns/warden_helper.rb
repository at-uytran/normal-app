module WardenHelper
  extend ActiveSupport::Concern

  included do
    helper_method :warden, :current_user, :user_signed_in?
  end

  def warden
    env["warden"]
  end

  def current_user
    warden.user :user
  end

  def user_signed_in?
    current_user.present?
  end
end
