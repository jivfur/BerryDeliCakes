class CakeOrdersController < ApplicationController
    
    def new
        @flavors = Flavor.all
        @previousCakes = Cake.find_by_gallery(true) #It will return previous cakes
        
        
    end
    
    def create
        #remember you need user Id for Orders
        #i need to send parameters that i need
        #save the cake..
        @cake = Cake.new(:flavor_id, :decorationImgURL, :comments, :levels, :gallery,:cake_id, :size, :price)
        #save the price...at this time it is only size...
        @cake_price = Cake_Price.new(:size => cake_order_params[:size])
        #save the order and status is ordered....
        @order = Order.new
        
    end
    
    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def cake_order_params
            params.require(:order).permit(:user_id, :deliveryDate, :deliveryAddress, :deliveryPhone, :status, :comments, :cakePrice_id, :paidStatus,:flavor_id, :decorationImgURL, :comments, :levels, :gallery,:cake_id, :size, :price)
        end
end
