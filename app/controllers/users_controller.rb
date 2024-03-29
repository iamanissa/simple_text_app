class UsersController < ApplicationController
  def new
     @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      redirect_to @user
    else  
      redirect :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.fetch(:user, {}).permit(
      :first_name, :last_name, :email,
      :password, :password_confirmation
    )
  end
end
