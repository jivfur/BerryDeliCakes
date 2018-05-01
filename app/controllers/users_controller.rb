require 'pp'
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  
  # GET /users
  # GET /users.json
  def index
    logger.debug "User/Index"
    @users = User.all
  end
  
  def signout
    puts "users ctrl -- signout"
    if session[:user_id] != nil
      puts "#{session[:user_id]} is tried to log out"
    end
    session[:user_id] = nil
    puts "session went to nil"
    flash[:notice] = 'successfully sign out'
    redirect_to users_path
  end
  
  # def userlist
  #   puts "users ctrl -- userlist"
  # end

  # GET /users/1
  # GET /users/1.json
  def show
    puts "users ctrl -- show"
  end

  # GET /users/new
  def new
    puts "users ctrl -- new"
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    puts "users ctrl -- edit"
        puts "edit -- session ctr"
        #Mypage :: edit user data
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
            flash[:notice] = 'successfully chage user name'
        end
        if (!(@user_cur.name.empty?)) && (@user_prev.name != @user_cur.name)
            puts "name changes"
            @user_prev.name = @user_cur.name
            flash[:notice] = 'successfully change name'
        end
        if (!(@user_cur.lastName.empty?)) && (@user_prev.lastName != @user_cur.lastName)
            puts "lastname changes"
            @user_prev.lastName = @user_cur.lastName
            flash[:notice] = 'successfully chage lastname'
        end
        if (!(@user_cur.email.empty?)) && (@user_prev.email != @user_cur.email)
            puts " email changes"
            @user_prev.email = @user_cur.email
            flash[:notice] = 'successfully chage email'
        end
        if (!(@user_cur.phone.empty?))&& (@user_prev.phone != @user_cur.phone)
            puts " phone changes"
            @user_prev.phone = @user_cur.phone
            flash[:notice] = 'successfully change phone number'
        end
        if (!(@user_cur.address.empty?)) && (@user_prev.address != @user_cur.address)
            puts " address changes"
            @user_prev.address = @user_cur.address
            flash[:notice] = 'successfully change address'
        end
        if (!(@user_cur.password.empty?)) && (@user_prev.password != @user_cur.password)
            puts " password changes"
            @user_prev.password = @user_cur.password
            flash[:notice] = 'successfully chage password'
        end
        if @user_prev.save
          flash[:notice] = 'successfully edited'
          redirect_to users_path
        else
          flash[:notice] = 'no response from server ... Please try again later'
          redirect_to users_path
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        # redirect_to users_path
  end

  # POST /users
  # POST /users.json
  def create
    puts "users ctrl -- create"
    #sign up part
      
      @user = User.new(user_params)
      @user_check_username = User.find_by_userName(@user.userName)
      @user_check_email = User.find_by_email(@user.email)
      if (@user_check_username != nil)
        puts "@user_check_username = #{@user_check_username.userName}"
      end
      if (@user_check_email != nil) 
        puts "@user_check_email = #{@user_check_email.userName}" 
      end
      puts "@user.userName = #{@user.userName}"
      puts "@user.password = #{@user.password}"
      
      if ( @user_check_username == nil && @user_check_email == nil )
      puts "@user nil"
        if (@user.password.length>=6)
          if (@user.userName == 'admin' && @user.password == 'adminPW')
            puts "admin case"
            @user.role = 1
            flash[:notice] = 'Hello admin, Have a NICE day'
          else @user.role = 0
          end
          respond_to do |format|
            if @user.save
              pp User.all
              flash[:notice] = 'successfully sign up'
              format.html { redirect_to users_path}
            else
              flash[:notice] = 'no response from server ... Please try again later'
              format.html { render :new }
              format.json { render json: @user.errors, status: :unprocessable_entity }
            end
          end
        else
          puts "password length is shorter than 6"
          flash[:notice] = 'password has to longer than 6'
          #redirect_to "/index.html" and return
          render html: "<script> alert('fadsadsa')</script>".html_safe
        end
      else
        puts "@user is already exist -- sad path"
        flash[:notice] = 'This user is already exist'
        redirect_to users_path #it would be better go to sign up page directly
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "users ctrl -- update"
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = 'successfully updated'
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    puts "users ctrl -- destroy"
    @user.destroy
    flash[:notice] = 'successfully destroyed user'
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    redirect_to sessions_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      puts "users ctrl -- set_user"
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def user_params
    #   params.fetch(:user, {})
    # end
    
    def user_params
      puts "users ctrl -- user_params"
      params[:user].delete :passwordConfirm
      params.require(:user).permit(:userName, :password, :name, :lastName, :phone, :email, :address)
    end
    
end
