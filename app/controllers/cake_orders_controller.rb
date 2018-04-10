class CakeOrdersController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def new
        @flavors = Flavor.all
        @previousCakes = Cake.find_by_gallery(true) #It will return previous cakes
        
        
    end
    
    
    def create
        #remember you need user Id for Orders
        #i need to send parameters that i need
        #I need flavors
        @flavor = Flavor.find_by_id(cake_order_params[:flavor_id])
        #save the cake..
        cakes_params = Hash.new
        cakes_params[:flavor_id]=@flavor.id
        cakes_params[:decorationImgURL]=cake_order_params[:decorationImgURL]
        cakes_params[:comments]=cake_order_params[:comments]
        cakes_params[:levels]=cake_order_params[:levels]
        cakes_params[:gallery]=false
        @cake = Cake.new(cakes_params)
        if @cake.save
            #@cake = Cake.find_by_decorationImgURL(@cake.decorationImgURL)
            logger.debug "Cake Id Is"+@cake.id.to_s
            #save the price...at this time it is only size...
            cake_price_params = Hash.new
            cake_price_params[:cake_id] = @cake.id
            cake_price_params[:size] = cake_order_params[:size]
            cake_price = CakePrice.new(cake_price_params)
            if cake_price.save
                #save the order and status is ordered....
                #I need a user...I was thinking that maybe there wont be necessary to have user
                logger.debug "Cake price "+cake_price.id.to_s
                #@cake = CakePrice.find_by_cake_id(@cake.id)
                logger.debug "Cake price "+cake_price.id.to_s
                order_params = Hash.new
                user = User.find_by_id(7);
                order_params[:user_id]=user.id
                order_params[:orderDate]=Time.now
                order_params[:deliveryDate]=cake_order_params[:deliveryDate]
                order_params[:deliveryAddress]=cake_order_params[:deliveryAddress]
                order_params[:deliveryPhone]=cake_order_params[:deliveryPhone]
                order_params[:status]=1
                order_params[:comments]=cake_order_params[:comments]
                order_params[:cakePrice]=cake_price.id
                order_params[:paidStatus]=0
                logger.debug Order.instance_methods
                @order = Order.new(order_params)
                logger.debug @order.orderDate
                logger.debug order_params
                if @order.valid?
                    @order.save
                    logger.debug @order
                    redirect_to orders_path(@order)
                else
                    logger.debug @order.errors.details
                end
            else
                logger.debug "Cake Price was not saved it"
            end
        else
            logger.debug "It was not saved it"
        end
    end
    
    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def cake_order_params
            params.require(:order).permit(:deliveryDate, :deliveryAddress, :deliveryPhone, :comments,:flavor_id, :decorationImgURL, :comments, :levels,:size)
        end
end
