class HomeController < ApplicationController
  def index
  	@restaurants = Restaurant.all
  end

  def dishlist
  	@ingredients= Ingredient.all.select(:id,:nombre)
  	render json: @ingredients
  end

  def ingredient
    @ingredient=Ingredient.new(ing_params)
    if @ingredient.save
      render json: {'Id'=>@ingredient.id,'Name'=>@ingredient.nombre}
    else
      render :nothing, :status => 400
    end
  end

  def ing_params
    params.require(:ingredient).permit(:nombre)
  end
end
