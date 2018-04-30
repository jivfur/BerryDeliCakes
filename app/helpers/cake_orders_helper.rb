module CakeOrdersHelper
    def paidStatusMethod
        #0 No Paid
        #1 Half Paid
        #2 Full Paid
        #3 Refund
        paidStatusDic = ["No Paid", "Half Paid", "Full Paid", "Refund"]
    end
    
    def orderStatusMethod
        #0 Submitted
        #1 Confirmed
        #2 In the oven
        #3 Delivered
        #4 Canceled
        orderStatusDic = ["Submitted", "Confirmed", "In the Oven", "Delivered","Canceled"]
    end

end