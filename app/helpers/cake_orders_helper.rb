module CakeOrdersHelper
    def paidStatusMethod
        #0 No Paid
        #1 Half Paid
        #2 Full Paid
        #3 Refund
        ["No Paid", "Half Paid", "Full Paid", "Refund"]
    end
    
    def orderStatusMethod
        #0 Submitted
        #1 Confirmed
        #2 In the oven
        #3 Delivered
        #4 Canceled
        ["Submitted", "Confirmed", "In the Oven", "Delivered","Canceled"]
    end
    
    
    def cakeSizeMethod
        {6=>"4 inches - 6 people",10=>"6 inches - 10 people",28=>"8 inches - 28 people",42=>"10 inches - 42 people",56=>"12 inches - 56 people"}
    end
    
    def decorationImgURLMethod(cake)
        src=cake.decorationImgURL
        if cake.gallery==true then
            src="previousCake/"+cake.decorationImgURL
        end
        return src
    end
end