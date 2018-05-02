class DishesController < ApplicationController
	before_action :set_restaurant
	before_action :validate_ownership

	def new
		@dish=@restaurant.dishes.build
	end

	def create
		@dish=@restaurant.dishes.build(dish_params)
		if @dish.save!
			redirect_to edit_restaurant_path(@restaurant)
		else
			render plain: "Fail"
		end
	end

	def destroy
		Dish.destroy(params[:id])
		redirect_to edit_restaurant_path(@restaurant)
	end

	def edit
		@dish=Dish.find(params[:id])
	end

	def update
		@dish=Dish.find(params[:id])
		if @dish.update(dish_params)
			redirect_to user_restaurant_path(current_user,@restaurant)
		else
			edit_restaurant_dish_path(@restaurant,@dish)
		end

	end




	private

	def dish_params
		params.require(:dish).permit(:nombre,:descripcion,:precio,:photo)
	end
	def set_restaurant
		@restaurant=Restaurant.find(params[:restaurant_id])
	end

	def validate_ownership
		@restaurant=Restaurant.find(params[:restaurant_id])
		if @restaurant.user != current_user
			redirect_to user_restaurants_path(current_user)
		end

	end
end
