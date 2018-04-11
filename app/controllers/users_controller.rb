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
    #user_params.delete :passwordConfirm
    
    # @user = User.where({:email => user_params[:email] || :userName => user_params[:userName]})
    # if @user.nil?
    #   redirect_to user_path() #User exist
    # else
    #   @user = User.new(user_params)
    
    # flag_exist_username = 0;
    
    # User.all.each do |user|
    #   if @user.userName == user.userName
    #     puts "same username in DB-- go to the index.html page directly"
    #     flash[:notice] = 'someone already use the user name'
    #     redirect_to "/index.html" and return

    #     flag_exist_username = 1;
    #   end
    # end
    # if (@user.password.length>=6)
    # else
    #   puts "password length is shorter than 6"
    #   flash[:notice] = 'password has to longer than 6'
    #   redirect_to "/index.html" and return
    # end
    # if valid_email?(@user.email)
    # else
    #   puts "not valid email"
    #   flash[:notice] = 'email format : xxx@xxx.xxx'
    #   redirect_to "/index.html" and return
    # end
    
    # pp User.all


    
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to "/index.html"}
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
    
    def valid_email?(email)
      
      email.present? &&
       (email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
       #&& User.find_by(email: email).empty?
    end
end
