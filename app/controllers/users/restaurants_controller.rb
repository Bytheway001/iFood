	class Users::RestaurantsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_restaurant,:only=>[:show,:destroy,:update,:edit]
	def index
		@restaurants=current_user.restaurants
	end

	def show
		@restaurant=Restaurant.find(params[:id])
	end

	def new
		@restaurant=current_user.restaurants.new
	end

	def create
		@restaurant=current_user.restaurants.new(restaurant_params)
		if @restaurant.save
			flash[:success]="Restaurant Creado Con exito"
			redirect_to users_restaurants_path(current_user)
		else
			flash[:error]="No se pudo crear el restaurant"
			redirect_to users_new_restaurant_path
		end
	end

	def destroy
		if @restaurant.destroy
			flash[:success]="Restaurant Eliminado Con exito"
			redirect_to users_restaurants_path
		else
			flash[:error]="No se pudo Eliminar el restaurant"
			redirect_to users_restaurants_path
		end
	end

	def get_notifications
		
	end

	def update
		if @restaurant.update(restaurant_params)
			redirect_to users_restaurants_path
		else
			redirect_to users_edit_restaurant_path(@restaurant)
		end
	end
	#Reporte de ventas
	def sales
		@restaurant=Restaurant.find(params[:restaurant_id])
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:nombre,:direccion,:telefono,:email,:logo,:lat,:long)
	end

	def set_restaurant
		@restaurant=Restaurant.find(params[:id])
	end


end