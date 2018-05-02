class Users::DishesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_dish, :only=>[:show,:edit,:destroy,:update]
	before_action :set_restaurant, :only=>[:new,:create]
	before_action :validate_ownership , :only=>[:show,:edit,:destroy,:update]
	def index
		@dishes=@restaurant.dishes;
	end

	def create
		@dish=@restaurant.dishes.new(dish_params)
		if @dish.save!
			flash[:success]="El restaurant ha sido creado"
			redirect_to users_restaurants_path(@dish.restaurant)
		else
			flash[:error]="Se ha producido un error"
			redirect_to new_users_restaurant_dish_path(@restaurant)
		end
	end

	def show
		
	end

	def new
		@ingredients=Ingredient.all
		@dish=@restaurant.dishes.new
	end

	def edit
		@restaurant=Restaurant.find(params[:restaurant_id])
		@ingredients=Ingredient.all
	end

	def destroy
		@dish.destroy
		redirect_to [:users,@dish.restaurant]
	end

	def update
		if @dish.update!(dish_params)
			flash[:success] = "Los cambios han sido guardados"
			redirect_to [:users,@dish.restaurant]
		else
			flash[:Error] = "No se pudieron guardar los cambios"
			redirect_to edit_users_restaurant_dish_path(@dish.restaurant,@dish)
		end
	end



	private
	def set_dish
		@dish=Dish.find(params[:id])
	end

	def set_restaurant
		@restaurant=Restaurant.find(params[:restaurant_id])
	end

	def validate_ownership
		if @dish.restaurant.user != current_user
			flash[:error]="Usted no tiene permisos para realizar esta accion"
			redirect_to root_path
		end
	end

	def dish_params
		params.require(:dish).permit(:nombre,:descripcion,:precio,:photo,addons_attributes:[:id,:ingredient_id,:price,:_destroy])
	end
end
