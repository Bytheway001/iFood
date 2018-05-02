class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre,:direccion,:cep])
	end

	def calcular_flete(restaurant,user=nil)
		if user==nil
			user=current_user
		end
		if(!restaurant.lat || !restaurant.long)
			@price=0
			return
		end

		price_meter=0.003
		uri= URI('https://maps.googleapis.com/maps/api/distancematrix/json')
		params={
			:units=>'meters',
			:origins=>restaurant.lat.to_s+','+restaurant.long.to_s,
			:destinations=>user.lat.to_s+','+user.long.to_s,
			:key=>'AIzaSyCWnQgHanCgGlxJ5vGHKoHywQUCq8Yum9A'
		}
		uri.query = URI.encode_www_form(params)
		@res = JSON.parse(Net::HTTP.get_response(uri).body)
		puts @res
		#me da la distancia en metro
		distance=@res['rows'][0]['elements'][0]['distance']['value']
		@price=(price_meter*distance.to_f).round(2)
	end
end
