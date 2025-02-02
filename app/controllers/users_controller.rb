class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_data = user_params
    user_data[:email] = user_data[:email].downcase
    @user = User.new(user_data)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def login_form
  end

  def show
    if current_user
      @user = User.find(params[:id])
    else
      flash[:notice] = "You must be logged in or registered to access your dashboard"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
