json.extract! order, :id, :user_id, :orderDate, :deliveryDate, :deliveryAddress, :deliveryPhone, :status, :comments, :cakePrice_id, :paidStatus, :created_at, :updated_at
json.url order_url(order, format: :json)
