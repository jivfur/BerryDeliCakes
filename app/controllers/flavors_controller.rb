class FlavorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_flavor, only: [:show, :edit, :update, :destroy]

  

  # GET /flavors
  # GET /flavors.json
  def index
    @flavors = Flavor.all
  end

  # GET /flavors/1
  # GET /flavors/1.json
  def show
  end

  # GET /flavors/new
  def new
  #   -if not(defined? session["role"]) || session["role"]==false then
  # -redirect_to users_path
    #@users = User.all
    if (session[:user_id] == nil) || (session[:role] == false)
      puts "here is flavors new, but this person is not admin --> go to users path"
      flash[:notice] = 'You are not allowed to this page. Only admin can make new flavors'
      redirect_to root_path
    end
    @flavor = Flavor.new
    
  end

  # GET /flavors/1/edit
  def edit
    pp "USER IS: "+session[:user_id].to_s
    if (session[:user_id] == nil) || (session[:role] == false)
      puts "here is flavors new, but this person is not admin --> go to users path"
      flash[:notice] = 'You are not allowed to this page. Only admin can manage flavors'
      redirect_to root_path
    end
  end

  # POST /flavors
  # POST /flavors.json
  def create
    if (session[:user_id] == nil) || (session[:role] == false)
      puts "here is flavors new, but this person is not admin --> go to users path"
      flash[:notice] = 'You are not allowed to this page. Only admin can manage flavors'
      redirect_to root_path
    end
    uploaded_io = params[:flavor][:flavorImgURL]
    File.open(Rails.root.join('public', 'flavorsUploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
    logger.debug uploaded_io.read
    end
    aux = {name: params[:flavor][:name],flavorImgURL: uploaded_io.original_filename};
    @flavor = Flavor.new(aux)
    respond_to do |format|
      if @flavor.save
        format.html { redirect_to @flavor, notice: 'Flavor was successfully created.' }
        format.json { render :show, status: :created, location: @flavor }
      else
        format.html { render :new }
        format.json { render json: @flavor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flavors/1
  # PATCH/PUT /flavors/1.json
  def update
    if (session[:user_id] == nil) || (session[:role] == false)
      puts "here is flavors new, but this person is not admin --> go to users path"
      flash[:notice] = 'You are not allowed to this page. Only admin can manage flavors'
      redirect_to root_path
    end
    aux = {name: params[:flavor][:name]}
    uploaded_io = params[:flavor][:flavorImgURL]
    logger.debug("uploaded_io type")
    if(uploaded_io)
      File.open(Rails.root.join('public', 'flavorsUploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      end
      aux[:flavorImgURL]= uploaded_io.original_filename;
    end
    respond_to do |format|
      if @flavor.update(aux)
        format.html { redirect_to @flavor, notice: 'Flavor was successfully updated.' }
        format.json { render :show, status: :ok, location: @flavor }
      else
        format.html { render :edit }
        format.json { render json: @flavor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flavors/1
  # DELETE /flavors/1.json
  def destroy
    if session[:role] ||session[:role] == False then
      redirect_to root_path()
    end
    @flavor.destroy
    respond_to do |format|
      format.html { redirect_to flavors_url, notice: 'Flavor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flavor
      @flavor = Flavor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flavor_params
      params.require(:flavor).permit(:name, :flavorImgURL)
    end
    
    
end
