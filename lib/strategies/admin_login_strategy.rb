class AdminLoginStrategy < ::Warden::Strategies::Base
  def valid?
    email.present? && password.present?
  end

  def authenticate!
    session.delete :admin_login_email
    account = Account.find_by(email: email)
    if account.valid_password? password
      admin = account.admin
      success! email
    else
      session.delete :admin_login_email
      fail! "Authenticate failed!"
    end
  end

  private
  def email
    params.dig(:admin, :email)&.strip
  end

  def password
    params.dig(:admin, :password)
  end
end
