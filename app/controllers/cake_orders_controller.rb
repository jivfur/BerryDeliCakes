require 'pp'
class CakeOrdersController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def new
        # if session[:user_id] 
        #     @user = User.find(session[:user_id] )
        # end    
        @flavors = Flavor.all
        @previousCakes = Cake.where({:gallery => true}) #It will return previous cakes
    end
    
    def previous
        @cake = Cake.find(params[:id])
        @flavors = Flavor.all
        @previousCakes = Cake.where({:gallery => true}) #It will return previous cakes
    end
    
    def index
        logger.debug(session[:user_id])
        @cakeOrders = Hash.new # this will be all the orders, organized by orders Id
        if(session[:user_id])
            user = User.find(session[:user_id])
            if(user.role == false)
                #you are not an admin
                logger.debug("this is the user"+user.id.to_s)
                orders = Order.where({:user_id =>user.id}).order(:created_at) #bring all the orders of this user ordered by creation date
            else
                #you are ad admin
                orders = Order.all.order(:created_at)
            end
            logger.debug("I found "+orders.length.to_s)
            orders.each_with_index do |order,order_index|
                myOrder = Hash.new
                cakePrice = CakePrice.find(order.cake_price_id)
                cake = Cake.find(cakePrice.cake_id)
                myOrder[:order] = order
                myOrder[:cake] = cake
                myOrder[:cakePrice] = cakePrice
                @cakeOrders[order.id]=myOrder
                logger.debug("Order is:" +  order.id.to_s)
            end
        else
            redirect_to("/")
        end    
    end
    
    def edit
        @flavors = Flavor.all
        order = Order.find params[:id]
        @myOrder = Hash.new
        cakePrice = CakePrice.find(order.cake_price_id)
        cake = Cake.find(cakePrice.cake_id)
        @myOrder[:order] = order
        
        @myOrder[:cake] = cake
        @checkedFlavor={cake.flavor_id => "selected"}
        @sizeSelected={cakePrice.size =>"selected"}
        @paidStatusDB = {order.paidStatus => "checked"}
        @statusDB = {order.status => "checked"}
        pp @statusDB
        @myOrder[:cakePrice] = cakePrice
    end
    
    
    def update
        @order = Order.find(params[:id])
        @cakePrice = CakePrice.find(@order.cake_price_id)
        @cake = Cake.find(@cakePrice.cake_id)
        cakes_params = Hash.new
        cakes_params[:flavor_id]=cake_order_params[:flavor_id]
        cakes_params[:comments]=cake_order_params[:comments]
        cakes_params[:levels]=cake_order_params[:levels]
        if( @cake.update(cakes_params)) then
            cake_price_params = Hash.new
            cake_price_params[:size] = cake_order_params[:size]
            cake_price_params[:price] = cake_order_params[:price]
            if(@cakePrice.update(cake_price_params)) then
                order_params = Hash.new
                order_params[:user_id]=session[:user_id]
                order_params[:deliveryDate]=cake_order_params[:deliveryDate]
                order_params[:deliveryAddress]=cake_order_params[:deliveryAddress]
                order_params[:deliveryPhone]=cake_order_params[:deliveryPhone]
                if(cake_order_params[:status])
                    order_params[:status]=cake_order_params[:status]
                end
                
                order_params[:comments]=cake_order_params[:comments]
                #order_params[:cake_price_id]=@cake_price.id
                if(cake_order_params[:paidStatus])
                    order_params[:paidStatus]=cake_order_params[:paidStatus]
                end
                #logger.debug Order.instance_methods
                if(@order.update(order_params))
                    redirect_to(cake_order_path(@order.id))
                end
            end
        end
    end
    
    def show
        @order = Order.find(params[:id])
        @cakePrice = CakePrice.find(@order.cake_price_id)
        @cake = Cake.find(@cakePrice.cake_id)
        flash[:notice] = "Your order looks delicious!!!"
        rescue ActiveRecord::RecordNotFound
            flash[:notice] = "Order was not Found"
    end
    
    
    def create
        Order.transaction do
        
        #remember you need user Id for Orders
        #i need to send parameters that i need
        #I need flavors
        #@flavor = Flavor.find_by_id(cake_order_params[:flavor_id])
        #save the cake..
        cakes_params = Hash.new
        cakes_params[:flavor_id]=cake_order_params[:flavor_id]
        cakes_params[:decorationImgURL]=cake_order_params[:decorationImgURL]
        cakes_params[:comments]=cake_order_params[:comments]
        cakes_params[:levels]=cake_order_params[:levels]
        cakes_params[:gallery]=false
        @cake = Cake.new(cakes_params)
        if @cake.save
            ####Uploading the picture#####
            orders_dir = Rails.root.join('public',@cake.id.to_s)
            Dir.mkdir(orders_dir) unless File.exists?(orders_dir) 
            uploaded_io = cake_order_params[:decorationImgURL]
            File.open(Rails.root.join(orders_dir, uploaded_io.original_filename), 'wb') do |file|
                file.write(uploaded_io.read)
            end
            @cake.decorationImgURL = File.join(@cake.id.to_s,uploaded_io.original_filename)
            #@cake.decorationImgURL = uploaded_io.original_filename
            @cake.save
            ########
            #@cake = Cake.find_by_decorationImgURL(@cake.decorationImgURL)
            logger.debug "Cake Id Is"+@cake.id.to_s
            #save the price...at this time it is only size...
            cake_price_params = Hash.new
            cake_price_params[:cake_id] = @cake.id
            cake_price_params[:size] = cake_order_params[:size]
            cake_price_params[:price] = 0.0
            @cake_price = CakePrice.new(cake_price_params)
            if @cake_price.save
                pp @cake_price
                #save the order and status is ordered....
                #I need a user...I was thinking that maybe there wont be necessary to have user
                ##@cake_price = CakePrice.find_by_cake_id(@cake.id)
                ##pp @cake_price
                order_params = Hash.new
                order_params[:user_id]=session[:user_id]
                order_params[:deliveryDate]=cake_order_params[:deliveryDate]
                order_params[:deliveryAddress]=cake_order_params[:deliveryAddress]
                order_params[:deliveryPhone]=cake_order_params[:deliveryPhone]
                order_params[:status]=0
                order_params[:comments]=cake_order_params[:comments]
                #order_params[:cake_price_id]=@cake_price.id
                order_params[:cake_price_id] =@cake_price.id
                order_params[:paidStatus]=0
                #logger.debug Order.instance_methods
                pp order_params
                
                @order = Order.new(order_params)
                logger.debug @order
                logger.debug order_params
                ##pp @cakePrice
                @order.cake_price_id=@cake_price.id
                if @order.save
                    flash[:notice] = "Your Cake is on its way!!!"
                    redirect_to cake_order_path(@order.id)
                else
                    
                    logger.debug "Order errors "
                    pp @order
                    pp @cake_price
                    logger.debug @order.errors.full_messages
                end
            else
                logger.debug "Cake Price Errors "
                logger.debug @cake_price.errors.full_messages
            end
            else
                logger.debug "Cake Errors: "
                logger.debug @cake.errors.full_messages
            end
        end
    end
    
    def createOrder
        Order.transaction do
            ########
            #@cake = Cake.find_by_decorationImgURL(@cake.decorationImgURL)
            #save the price...at this time it is only size...
            cake_price_params = Hash.new
            pp cake_order_params
            puts "This is cake ID"+cake_order_params[:cake_id].to_s
            cake_price_params[:cake_id] = cake_order_params[:cake_id]
            cake_price_params[:size] = cake_order_params[:size]
            cake_price_params[:price] = 0.0
            @cake_price = CakePrice.new(cake_price_params)
            if @cake_price.save
                pp @cake_price
                #save the order and status is ordered....
                #I need a user...I was thinking that maybe there wont be necessary to have user
                ##@cake_price = CakePrice.find_by_cake_id(@cake.id)
                ##pp @cake_price
                order_params = Hash.new
                order_params[:user_id]=session[:user_id]
                order_params[:deliveryDate]=cake_order_params[:deliveryDate]
                order_params[:deliveryAddress]=cake_order_params[:deliveryAddress]
                order_params[:deliveryPhone]=cake_order_params[:deliveryPhone]
                order_params[:status]=0.0
                order_params[:comments]=cake_order_params[:comments]
                #order_params[:cake_price_id]=@cake_price.id
                order_params[:cake_price_id] =@cake_price.id
                order_params[:paidStatus]=0.0
                #logger.debug Order.instance_methods
                pp order_params
                
                @order = Order.new(order_params)
                logger.debug @order
                logger.debug order_params
                ##pp @cakePrice
                @order.cake_price_id=@cake_price.id
                if @order.save
                    flash[:notice] = "Your Cake is on its way!!!"
                    redirect_to cake_order_path(@order.id)
                else
                    
                    logger.debug "Order errors "
                    pp @order
                    pp @cake_price
                    logger.debug @order.errors.full_messages
                end
            else
                    logger.debug "Cake Price Errors "
                    logger.debug @cake_price.errors.full_messages
            end
        end
    end
    
    def destroy
        @order = Order.find(params[:id])
        @cake_price = CakePrice.find(@order.cake_price_id)
        @cake = Cake.find(@cake_price.cake_id)
        if session[:role] == true and @order.status == 4 then #if  you are admin you can delete only if user canceled before
            @order.destroy()
            @cake_price.destroy()
            if @cake.gallery==false then #Cake could be a previous design, we do not want to delete those.
                @cake.destroy() 
            end
        else
            #0 Submitted
            #1 Confirmed
            #2 In the oven
            #3 Delivered
            #4 Canceled
            @order.update({:status =>4})
        end    
           redirect_back(fallback_location: root_path)      
    end
    
    
    
    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def cake_order_params
            params.require(:order).permit(:cake_id,:user_id,:deliveryDate, :deliveryAddress, :deliveryPhone, :comments,:flavor_id, :decorationImgURL, :comments, :levels,:size , :price, :paidStatus, :status)
        end
end

