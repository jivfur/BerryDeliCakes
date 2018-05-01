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
        check_first = 0
        check_change = 0
        #Mypage :: edit user data
        #@user = User.find_by_userName(params[:username])
        # @user = User.new
        #@user = User.new(user_params)
        #@user_prev = User.find_by_id(params[:id])
        @user_prev = current_user
        if (params[:user] != nil)
            #@user = User.new(params[:user])
            puts "let's make @user"
            @user = User.new(user_params)
            check_first = 1
            puts "@user : #{@user}"
        end

        puts "@user_prev.userName : #{@user_prev.userName}"
        puts "@user_prev.password : #{@user_prev.password}"
        puts "@user : #{params[:user]}"
        # puts "@user.password : #{@user.password}"
        puts "check point 1"
        puts "check_first : #{check_first}"
        if (check_first == 1)
            if ((check_first == 1) && !(@user.userName.empty?)) && (@user_prev.userName != @user.userName)
                puts "username changes"
                @user_prev.userName = @user.userName
                check_change = 1
                flash[:notice] = 'successfully chage user name'
            end
            if ((check_first == 1) && !(@user.name.empty?)) && (@user_prev.name != @user.name)
                puts "name changes"
                @user_prev.name = @user.name
                check_change = 1
                flash[:notice] = 'successfully change name'
            end
            if ((check_first == 1) && !(@user.lastName.empty?)) && (@user_prev.lastName != @user.lastName)
                puts "lastname changes"
                @user_prev.lastName = @user.lastName
                check_change = 1
                flash[:notice] = 'successfully chage lastname'
            end
            if ((check_first == 1) && !(@user.email.empty?)) && (@user_prev.email != @user.email)
                puts " email changes"
                @user_prev.email = @user.email
                check_change = 1
                flash[:notice] = 'successfully chage email'
            end
            if ((check_first == 1) && !(@user.phone.empty?))&& (@user_prev.phone != @user.phone)
                puts " phone changes"
                @user_prev.phone = @user.phone
                check_change = 1
                flash[:notice] = 'successfully change phone number'
            end
            if ((check_first == 1) && !(@user.address.empty?)) && (@user_prev.address != @user.address)
                puts " address changes"
                @user_prev.address = @user.address
                check_change = 1
                flash[:notice] = 'successfully change address'
            end
            if ((check_first == 1) && !(@user.password.empty?)) && (@user_prev.password != @user.password)
                puts " password changes"
                @user_prev.password = @user.password
                check_change = 1
                flash[:notice] = 'successfully chage password'
            end
            check_first = 0
            puts "check point 2"
        end
        if (check_change == 0)
            puts "no changes"
            flash[:notice] = 'If you do not want to edit something, please go another direction'
        end
        puts "check point 3"
        puts "check_first : #{check_first}"
        puts "check_change : #{check_change}"
        if (check_change == 1)
            puts "check point 4"
            if @user_prev.save
              puts "check point 5"
              flash[:notice] = 'successfully edited'
              redirect_to users_path 
            else
              flash[:notice] = 'no response from server ... Please try again later'
              redirect_to users_path
              format.html { render :new }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
        # redirect_to users_path
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
