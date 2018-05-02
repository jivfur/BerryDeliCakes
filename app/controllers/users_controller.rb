require 'pp'
class UsersController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  
  # GET /users
  # GET /users.json
  def index
    logger.debug "User/Index"
    @users = User.all
    #deleteAllUsers()
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
  # GET user/deleteAllUsers
  def deleteAllUsers
    users = User.all
    users.each do |user|
      orders = Order.where({:user_id => user.id})
      orders.each do |order|
        cakesPrice = CakePrice.where({:id=>order.cake_price_id})
        order.destroy()
        cakesPrice.each do |cakePrice|
          cakes = Cake.where({:id =>cakePrice.cake_id})
          cakePrice.destroy()
          cakes.each do |cake|
            cake.destroy()
          end
        end
      end
      user.destroy()
    end
  end
  # POST /users
  # POST /users.json
  def create
    user_params.except(:confirmPassword)
    aux = user_params.except(:confirmPassword)
    aux[:role] = true
    @user = User.new(aux)
    if(@user.save)
       flash[:notice] = "Your profile was created"
       log_in(@user)
       redirect_to edit_user_path(@user.id)
    else
      flash[:danger] = "Something went wrong"
      redirect_to root_path()
    end
    
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
