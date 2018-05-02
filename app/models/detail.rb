class Detail < ApplicationRecord
  belongs_to :order
  belongs_to :dish
  has_many :additionals, dependent: :destroy
  accepts_nested_attributes_for :additionals

  def calculate_price
  	extras=0;
  	self.additionals.each do |add|
  		extras=extras+add.addon.price
  	end
  	finalprice=self.qty*(extras+self.dish.precio)
  	return finalprice
  end
end
