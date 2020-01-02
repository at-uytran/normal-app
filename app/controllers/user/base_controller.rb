class User::BaseController < ApplicationController
  private
  def authenticate_user!
  end

  def sign_in object
    binding.pry
  end
end
