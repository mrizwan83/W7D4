class SessionsController < ApplicationController
  #   resource :session, only: [:new, :create, :destroy]
 

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      log_in_user(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid credentials"]
      render :new
    end

  end

  def destroy
    log_out_user
    redirect_to new_session_url
  end

end
