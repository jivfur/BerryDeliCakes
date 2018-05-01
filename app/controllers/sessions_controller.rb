require 'pp'
class SessionsController < ApplicationController
    include SessionsHelper
    skip_before_action :verify_authenticity_token
    def new
    end
    
    def index
        # listing user part
        if current_user == nil
            flash[:notice] = 'it is required to log in as admin. Please try to login.'
            redirect_to users_path
        end
        if (current_user !=nil) && (current_user.role == false)
            puts "illegal path"
            flash[:notice] = 'it is allowed only for admin'
            redirect_to users_path
        end
        @user = User.all
    end
   
    def show
      #admin test!!
      puts "session ctrl -- admin test"
      @users = User.all
      @orders = Order.all
      
    end
    
    def edit
        #user data edit
        puts "edit -- session ctr"
        
        user = User.find params[:id]
        pp user
        @user_new = Hash.new
        #@user_new = user
        @user_new[:user] = user
        # @user_new[:password] = user.password
        # @user_new[:phone] = user.phone
        # @user_new[:email] = user.email
        # @user_new[:address] = user.address
        pp @user_new
    end
    
    def update
        #user data edit
        
        puts "update -- session ctrl"
        
        @user = User.find params[:id]
        puts "user'id : #{@user.id}"
        puts "user'username : #{@user.userName}"
        puts "user'address : #{@user.address}"
        puts "point 1"
        usernew_params = Hash.new
        puts "point 2"
        usernew_params[:password]=user_params[:password]
        puts "point 3"
        usernew_params[:phone]=user_params[:phone]
        puts "point 4"
        usernew_params[:email]=user_params[:email]
        usernew_params[:address]=user_params[:address]
        puts "user_params[:address] : #{user_params[:address]}"
        # if(@userprev.update(user_params))
        #     redirect_to(users_path)
        # end
        #if(user.update(user_params))
        if(@user.update(usernew_params)) then
            flash[:notice] = 'successfully updated profile'
            redirect_to(users_path)
        else
            flash[:notice] = 'fail to update profile'
            redirect_to edit_session_path
        end
    end

    def create
        #login part
        puts "session -- create"

        @user = User.find_by_userName(params[:username])
        
        if (params[:username] == 'admin' && params[:password] == 'adminPW')
            if(@user != nil)
                puts "admin case"
                @user.role =1
                puts "@user.role = #{@user.role}"
                log_in(@user)
                flash[:notice] = 'You logged in as a admin!'
            else
                puts "admin case -- not exist admin"
                flash[:notice] = 'You have to sign up admin first!!'
            end
            #redirect_to sessions_path
            redirect_to users_path
            #where is the admin dashboard??
            
        elsif (!@user.nil?)
            puts "there is potential user exist"
            if @user.password == params[:password]
                puts "password match"
                log_in(@user)
                flash[:notice] = 'Hello! Successfully logged in!'
                redirect_to new_cake_order_path # Where to redirect when user is correct
                #redirect_to users_path
            else
                puts "password is not match"
                flash[:notice] = 'please think about password again'
                flash[:danger] = 'Invalid email/password combination' # Not quite right!
                redirect_to users_path
            end
        else
            puts "no user detected"
            flash[:notice] = 'OH! there is no such user! Please try again'
        end
    end

    def destroy
        #logout path
        puts "session -- destroy"
        log_out
        #redirect_to root_url
    end
    
    private
    
    def user_params
      puts "users ctrl -- user_params"

      #params[:user].delete :passwordConfirm
      params.require(:user).permit(:userName, :password, :name, :lastName, :phone, :email, :address)
    end
    
end
