class SessionsController < ApplicationController

  layout false
  
  def new
  end
  
  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      redirect_to '/login'
    end 
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
  
end

