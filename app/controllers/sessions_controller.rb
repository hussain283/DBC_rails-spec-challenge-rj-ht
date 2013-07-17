class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].downcase.strip)
    if user && user.authenticate(params[:password])
      login user
      redirect_to root_path
    else
      @message = "Invalid Username or Password"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
