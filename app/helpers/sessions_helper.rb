require 'pp'
module SessionsHelper
    def log_in(user)
        ##slogger.debug
        pp user
        #session[:user_id] = user.id
        session[:loggedIn] = "BerryDeliCakesUserAccepted"
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def log_out
        session.delete(:user_id)
        @current_user = nil 
    end
end
