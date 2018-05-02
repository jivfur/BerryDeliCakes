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
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    if(user = User.find({:userName => "admin"}))
      user.destroy()
    end
    user_params.except(:confirmPassword)
    aux = user_params.except(:confirmPassword)
    aux[:role] = true
    @user = User.new(aux)
    if(@user.save)
       flash[:notice] = "Your profile was created"
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_to edit_user_path(@user.id)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    aux = user_params.except(:confirmPassword)
    if(@user.update(aux))
      flash[:notice] = "Your profile was updated"
    else
      flash[:danger] = "Something went wrong"
    end
    redirect_to edit_user_path(@user.id)
    
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
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:userName, :password, :confirmPassword, :name, :lastName, :phone, :email, :address)
    end
    
end
