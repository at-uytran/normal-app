class UserLoginStrategy < ::Warden::Strategies::Base
  def valid?
    email.present? && password.present?
  end

  def authenticate!
    session.delete :user_login_email
    account = Account.find_by(email: email)
    if account.valid_password? password
      user = account.user
      success! email
    else
      session.delete :user_login_email
      fail! "Authenticate failed!"
    end
  end

  private
  def email
    params.dig(:user, :email)&.strip
  end

  def password
    params.dig(:user, :password)
  end
end
