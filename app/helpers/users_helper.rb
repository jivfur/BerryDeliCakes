module UsersHelper
    
    def logged_out?
      puts "logged out helper"
      if session[:user_id].nil?
        return true
      else
        return false
      end
    end
    def signged_in?
      puts "signged in helper"
      if !session[:user_id].nil?
        return true
      else
        return false
      end
   end
end
