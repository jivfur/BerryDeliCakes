class CakePrice < ApplicationRecord
  belongs_to :cake
  has_one :order
end
