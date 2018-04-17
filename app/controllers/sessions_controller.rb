class SessionsController < ApplicationController
    include SessionsHelper
    skip_before_action :verify_authenticity_token
    def new
    end
    
    def index
        @user = User.all
    end
    
    def edit
        #@user = User.find_by_userName(params[:username])
        @user_cur = User.new(user_params)
        @user_prev = current_user
        puts "@user_cur.userName : #{@user_cur.userName}"
        puts "@user_cur.password : #{@user_cur.password}"
        puts "@user_cur.email : #{@user_cur.email}"
        puts "@user_prev.userName : #{@user_prev.userName}"
        puts "@user_prev.password : #{@user_prev.password}"
        puts "@user_cur.email.empty? : #{@user_cur.email.empty?}"
        
        if (!(@user_cur.userName.empty?)) && (@user_prev.userName != @user_cur.userName)
            puts "username changes"
            @user_prev.userName = @user_cur.userName
        end
        if (!(@user_cur.name.empty?)) && (@user_prev.name != @user_cur.name)
            puts "name changes"
            @user_prev.name = @user_cur.name
        end
        if (!(@user_cur.lastName.empty?)) && (@user_prev.lastName != @user_cur.lastName)
            puts "lastname changes"
            @user_prev.lastName = @user_cur.lastName
        end
        if (!(@user_cur.email.empty?)) && (@user_prev.email != @user_cur.email)
            puts " email changes"
            @user_prev.email = @user_cur.email
        end
        if (!(@user_cur.phone.empty?))&& (@user_prev.phone != @user_cur.phone)
            puts " phone changes"
            @user_prev.phone = @user_cur.phone
        end
        if (!(@user_cur.address.empty?)) && (@user_prev.address != @user_cur.address)
            puts " address changes"
            @user_prev.address = @user_cur.address
        end
        if (!(@user_cur.password.empty?)) && (@user_prev.password != @user_cur.password)
            puts " password changes"
            @user_prev.password = @user_cur.password
        end
        redirect_to users_path
    end

    def create
        #login path
        puts "session -- create"

        @user = User.find_by_userName(params[:username])
        
        if (params[:username] == 'admin' && params[:password] == 'adminPW')
            puts "admin case"
            @user.role =1
            puts "@user.role = #{@user.role}"
            log_in(@user)
            redirect_to sessions_path
            #redirect_to new_flavor #where is the admin dashboard??
        elsif (!@user.nil?)
            puts "there is potential user exist"
            if @user.password == params[:password]
                puts "password match"
                log_in(@user)
                redirect_to new_cake_order_path # Where to redirect when user is correct
                #redirect_to users_path
            else
                puts "password is not match"
                flash[:danger] = 'Invalid email/password combination' # Not quite right!
                redirect_to root_path
            end
        else
            puts "no user detected"
        end
    end

    # def userlist
    #     puts "session -- userlist"
    # end

    def destroy
        #logout path
        puts "session -- destroy"
        log_out
        #redirect_to root_url
    end
    
    private
    
    def user_params
      puts "users ctrl -- user_params"
      params[:user].delete :passwordConfirm
      params.require(:user).permit(:userName, :password, :name, :lastName, :phone, :email, :address)
    end
    
end
