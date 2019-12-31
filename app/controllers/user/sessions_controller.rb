class User::SessionsController < User::BaseController
  layout "user/unauthenticate_layout"
  def new
    
  end

  def create
  end

  private
  def user_params
    params.require(:user).permit(:password, :email)
  end
end
