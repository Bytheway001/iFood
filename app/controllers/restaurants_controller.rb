require 'net/http'
class RestaurantsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_ownership, :only=>[:edit]
	before_action :set_restaurant, :only=>[:edit,:show]
	before_action only:[:show] do 
		calcular_flete @restaurant
	end
	def show
		
	end

	def edit
	end

	def notifications
		@notifications=current_user.notifications.where(:read=>false)
	end

	private

	
	def set_restaurant
		@restaurant=Restaurant.find(params[:id])
	end
end
