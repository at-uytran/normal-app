require Rails.root.join("lib", "strategies", "admin_login_strategy")
require Rails.root.join("lib", "strategies", "user_login_strategy")

Warden::Strategies.add(:admin_login, AdminLoginStrategy)
Warden::Strategies.add(:user_login, UserLoginStrategy)
