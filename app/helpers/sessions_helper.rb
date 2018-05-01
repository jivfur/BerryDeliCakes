module SessionsHelper
    def log_in(user)
        ##slogger.debug
        pp user[0].id
        session[:user_id] = user[0].id
        session[:loggedIn] = "BerryDeliCakesUserAccepted"
        session[:role] = user[0].role
    end
    
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def log_out
        session[:user_id] = -1
        session[:loggedIn] = "G0T0F4C3800K"
        session[:role] = false
        session.delete(:user_id)
        session.delete(:loggedIn)
        session.delete(:role)
        @current_user = nil 
        flash[:notice] = 'successfully sign out'
        
    end
end
