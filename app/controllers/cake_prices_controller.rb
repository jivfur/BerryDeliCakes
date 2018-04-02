class CakePricesController < ApplicationController
  before_action :set_cake_price, only: [:show, :edit, :update, :destroy]

  # GET /cake_prices
  # GET /cake_prices.json
  def index
    @cake_prices = CakePrice.all
  end

  # GET /cake_prices/1
  # GET /cake_prices/1.json
  def show
  end

  # GET /cake_prices/new
  def new
    @cake_price = CakePrice.new
  end

  # GET /cake_prices/1/edit
  def edit
  end

  # POST /cake_prices
  # POST /cake_prices.json
  def create
    @cake_price = CakePrice.new(cake_price_params)

    respond_to do |format|
      if @cake_price.save
        format.html { redirect_to @cake_price, notice: 'Cake price was successfully created.' }
        format.json { render :show, status: :created, location: @cake_price }
      else
        format.html { render :new }
        format.json { render json: @cake_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cake_prices/1
  # PATCH/PUT /cake_prices/1.json
  def update
    respond_to do |format|
      if @cake_price.update(cake_price_params)
        format.html { redirect_to @cake_price, notice: 'Cake price was successfully updated.' }
        format.json { render :show, status: :ok, location: @cake_price }
      else
        format.html { render :edit }
        format.json { render json: @cake_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cake_prices/1
  # DELETE /cake_prices/1.json
  def destroy
    @cake_price.destroy
    respond_to do |format|
      format.html { redirect_to cake_prices_url, notice: 'Cake price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cake_price
      @cake_price = CakePrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cake_price_params
      params.require(:cake_price).permit(:cake_id, :size, :price)
    end
end
