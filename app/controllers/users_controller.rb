class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user= User.new(user_params)
    if @user.save
      redirect_to new_path, notice:
      "Welcome #{@user.userid}"
    else
      render new
    end
  end
end
