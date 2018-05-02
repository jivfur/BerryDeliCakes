require 'pp'
class SessionsController < ApplicationController
    include SessionsHelper
    skip_before_action :verify_authenticity_token
    def new
    end
    
    def create
        user = User.where({:userName =>params[:username].downcase, :password =>params[:password]})
        pp user
        if user.empty? then
            # Create an error message.
            flash[:danger] = 'Invalid username/password combination'
            redirect_to new_session_path()
        else
        # Log the user in and redirect to the user's show page.
          log_in(user[0])
          redirect_to cake_orders_path()
        
        end
    end

    def destroy
        #logout path
        puts "session -- destroy"
        log_out
        redirect_to root_path
    end
    
    private
    
    def user_params
      params.require(:user).permit(:userName, :password)
    end
    
end
