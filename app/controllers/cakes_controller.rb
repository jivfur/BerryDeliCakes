
class CakesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_cake, only: [:show, :edit, :update, :destroy]

  # GET /cakes
  # GET /cakes.json
  def index
    @cakes = Cake.where({:gallery => true})
  end

  # GET /cakes/1
  # GET /cakes/1.json
  def show
  end

  # GET /cakes/new
  def new
  end

  # GET /cakes/1/edit
  def edit
  end

  # POST /cakes
  # POST /cakes.json
  def create
    aux = {levels: params[:cake][:levels], gallery: true, flavor_id: Flavor.last.id, comments: params[:cake][:comments]}
    uploaded_io = params[:cake][:decorationImgURL]
    logger.debug("uploaded_io type")
    folderAux=Time.now.to_i.to_s
    orders_dir = Rails.root.join("public","previousCake",folderAux)
    Dir.mkdir(orders_dir) unless File.exists?(orders_dir)
    if(uploaded_io)
      File.open(Rails.root.join(orders_dir, uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      end
      aux[:decorationImgURL]= File.join(folderAux,uploaded_io.original_filename);
    end
    
    @cake = Cake.new(aux)

    respond_to do |format|
      if @cake.save
        format.html { redirect_to cakes_path, notice: 'Cake was successfully created.' }
        format.json { render :show, status: :created, location: @cake }
      else
        format.html { render :new }
        format.json { render json: @cake.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cakes/1
  # PATCH/PUT /cakes/1.json
  def update
    respond_to do |format|
      if @cake.update(cake_params)
        format.html { redirect_to @cake, notice: 'Cake was successfully updated.' }
        format.json { render :show, status: :ok, location: @cake }
      else
        format.html { render :edit }
        format.json { render json: @cake.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cakes/1
  # DELETE /cakes/1.json
  def destroy
    @cake.destroy
    respond_to do |format|
      format.html { redirect_to cakes_url, notice: 'Cake was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cake
      @cake = Cake.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cake_params
      params.require(:cake).permit(:flavor_id, :decorationImgURL, :comments, :levels, :gallery)
    end
end
