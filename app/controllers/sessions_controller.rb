class SessionsController < ApplicationController
    include SessionsHelper
    skip_before_action :verify_authenticity_token
    def new
    end

    def create
        #login path
        puts "session -- create"

        @user = User.find_by_userName(params[:username])
        
        if (params[:username] == 'admin' && params[:password] == 'adminPW')
            puts "admin case"
            @user.role =1
            puts "@user.role = #{@user.role}"
        end

        if (!@user.nil?)
            puts "there is potential user exist"
            if @user.password == params[:password]
                puts "password match"
                log_in(@user)
                #redirect_to new_cake_order_path # Where to redirect when user is correct
                redirect_to users_path
            else
                puts "password is not match"
                flash[:danger] = 'Invalid email/password combination' # Not quite right!
                redirect_to root_path
            end
        else
            puts "no user detected"
        end
    end

    def destroy
        #logout path
        puts "session -- destroy"
        log_out
        redirect_to root_url
    end
end
