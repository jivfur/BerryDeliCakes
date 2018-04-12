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
  end

  # POST /users
  # POST /users.json
  def create
    puts "users ctrl -- create"
    
    @user_check_username = User.find_by_userName(params[:username])
    @user_check_email = User.find_by_userName(params[:email])
    if ( @user_check_username == nil && @user_check_email == nil )
      puts "@user nil"
      
      @user = User.new(user_params)
      puts "@user.userName = #{@user.userName}"
      puts "@user.password = #{@user.password}"
      if (@user.password.length>=6)
        if (@user.userName == 'admin' && @user.password == 'adminPW')
          puts "admin case"
          @user.role = 1
        end
        respond_to do |format|
          if @user.save
            pp User.all
            format.html { redirect_to "/index.html"}
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
      else
        puts "password length is shorter than 6"
        flash[:notice] = 'password has to longer than 6'
        redirect_to "/index.html" and return
      end
    else
      puts "@user is already exist -- sad path"
      redirect_to "/index.html" #it would be better go to sign up page directly
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "users ctrl -- update"
    respond_to do |format|
      if @user.update(user_params)
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
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
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
