class Order < ApplicationRecord
	belongs_to :user
	belongs_to :restaurant
	has_many :notifications, dependent: :destroy
	has_many :details, dependent: :destroy
	accepts_nested_attributes_for :details

	def subtotal
		total=0
		self.details.each do |d|
			price=d.dish.precio
			d.additionals.each do |a|
				price=price+a.addon.price
			end
			total=total+d.qty*(price)
		end
		return total
	end
	def total_price
		return subtotal+calcular_flete()
	end

	def calcular_flete()
		@price=0
		if(!restaurant.lat || !restaurant.long)
			@price=0
			return @price
		end
		price_meter=0.003
		uri= URI('https://maps.googleapis.com/maps/api/distancematrix/json')
		params={
			:units=>'meters',
			:origins=>self.restaurant.lat.to_s+','+self.restaurant.long.to_s,
			:destinations=>self.user.lat.to_s+','+self.user.long.to_s,
			:key=>'AIzaSyCWnQgHanCgGlxJ5vGHKoHywQUCq8Yum9A'
		}
		uri.query = URI.encode_www_form(params)
		@res = JSON.parse(Net::HTTP.get_response(uri).body)
		puts @res
		#me da la distancia en metro
		distance=@res['rows'][0]['elements'][0]['distance']['value']
		@price=(price_meter*distance.to_f).round(2)
		return @price
	end

	private
	
end