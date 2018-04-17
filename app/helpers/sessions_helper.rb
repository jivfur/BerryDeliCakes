
module SessionsHelper
    def log_in(user)
        ##slogger.debug
        session[:user_id] = user.id
        session[:loggedIn] = "BerryDeliCakesUserAccepted"
        session[:role] = user.role
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def log_out
        session.delete(:user_id)
        @current_user = nil 
        flash[:notice] = 'successfully sign out'
    end
end
