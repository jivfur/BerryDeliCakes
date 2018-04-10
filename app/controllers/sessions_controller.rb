class SessionsController < ApplicationController
    def new
    end

    def create
        #login path
        puts "session -- create"
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in user
            #redirect_to user # Where to redirect when user is correct
        else
            flash[:danger] = 'Invalid email/password combination' # Not quite right!
            render 'new'
        end
    end

    def destroy
        #logout path
        puts "session -- destroy"
        log_out
        redirect_to root_url
    end
end
