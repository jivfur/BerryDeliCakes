class SessionsController < ApplicationController
    include SessionsHelper
    skip_before_action :verify_authenticity_token
    def new
    end

    def create
        #login path
        puts "session -- create"
        logger.debug params
        #user = User.where("userName =?  AND password = ?",params[:username],params[:password])
        user = User.find_by_userName(params[:username])
        if user
            log_in(user)
            redirect_to new_cake_order_path # Where to redirect when user is correct
        else
            flash[:danger] = 'Invalid email/password combination' # Not quite right!
            redirect_to root_path
        end
    end

    def destroy
        #logout path
        puts "session -- destroy"
        log_out
        redirect_to root_url
    end
end
