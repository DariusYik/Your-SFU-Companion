class SessionsController < ApplicationController

  layout false
  
  def new
  end
  
  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to '/welcome'
    else
      # flash.now[:danger] = 'Invalid email/password combination'
      redirect_to '/login'
    end 
  end
  
  def destroy
    log_out
    redirect_to '/'
  end
  
end

