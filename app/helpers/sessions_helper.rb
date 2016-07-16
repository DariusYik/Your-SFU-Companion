module SessionsHelper

	# Logs in the given user.
	def log_in(user)
	   session[:user_id] = user.id
	end

	# Remembers a user in a persistent session.
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# Returns the current logged-in user (if any).
	def current_user
	    if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
	    elsif (user_id = cookies.signed[:user_id])
			@user = User.find_by(id: user_id)
			if @user && @user.authenticated?(cookies[:remember_token])
				log_in @user
				@current_user = @user
	      	end
	    end
	end

	
	def require_user 
		redirect_to '/login' unless current_user 
	end

	def require_admin
		redirect_to '/' unless current_user.email == "admin@email.com"
	end

	def require_no_login
		redirect_to '/welcome' unless !current_user
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end	

  	# Logs out the current user.
  	def log_out
	    forget(current_user)
	    session.delete(:user_id)
	    @current_user = nil
    end
    
	# # Returns true if the user is logged in, false otherwise.
 #  	def logged_in?
 #    	!current_user.nil?
 #  	end
end
