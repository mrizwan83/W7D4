class UsersController < ApplicationController
 # resources :users, only: [:new, :create, :show]
  before_action :require_logged_in, only: [:show]
  before_action :require_logged_out, only: [:new, :create]

 def new
  @user = User.new
  render :new
 end

 def create
  @user = User.new(user_params)
  if @user.save
    log_in_user(@user)
    redirect_to user_url(@user)
  else
    flash.now[:errors] = @user.errors.full_messages
    render :new
  end
 end

 def index
  @users = User.all 
  render :index
 end

 def show
  @user = User.find_by(id: params[:id])
  render :show
 end

 private 

 def user_params
  params.require(:user).permit(:username, :password)
 end
  
end
