class Cake < ApplicationRecord
  belongs_to :flavor
  has_many :cakePrice
end
