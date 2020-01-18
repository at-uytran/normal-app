class User::SessionsController < User::BaseController
  layout "user/unauthenticate_layout"
  before_action :load_account, only: [:create]

  def new
  end

  def create
    is_valid_password = @account.valid_password?(user_params[:password])
    if is_valid_password
      sign_in @user
    else
      flash.now[:danger] = "Incorrect email or password"
      render :new
    end
  end

  private
  def load_account
    @account = Account.find_by(email: user_params[:email])
    unless @account
      flash.now[:error] = "Incorrect email or password"
      return render :new
    end
    @user = @account.user
  end
    
  def user_params
    params.require(:user).permit(:password, :email)
  end
end
