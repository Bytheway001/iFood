class OrdersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_order, :only=>[:show,:validate_ownership,:status]

	def index
		@orders=current_user.orders
	end

	def show
		:validate_ownership
		calcular_flete @order.restaurant
	end

	def status
		
		case @order.status # a_variable is the variable we want to compare
			when 0    #compare to 1
  				status= 'cooking.gif'
			when 1    #compare to 2
  				status='ready.gif'
			else
  				puts "it was something else"
		end
		render json: status
	end

	def confirm
		@order=Order.find(params[:order])
		if	@order.update_attributes(:status=>1,:payment_type=>params[:payment_type],:change=>params[:change])
			render json: @order, :status => 200
		else
			render :status => 400
		end
	end

	def create
		#Pedidos se refiere a lo que el usuario pidio (como cliente)

		@order=current_user.pedidos.new(order_params)
		if @order.save!
			@order.notifications.create!(:read=>false)
			render json: @order, :status => 200
		else
			render :status => 400
		end

	end

	def cartmodal
		@dish=Dish.find(params[:id])
		render partial: 'partials/cart_modal';
	end

	def paymodal

		@order=current_user.orders.new(order_params)
		calcular_flete @order.restaurant
		render partial: 'partials/pay_modal'
	end

	private
	def validate_ownership
		if @order.user != current_user
			flash[:error]="Usted no tiene permisos para validar esta orden"
			redirect_to root_path
		end

	end

	def set_order
		@order=Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:restaurant_id,:payment_type,:change,details_attributes:[:dish_id,:comment,:qty,additionals_attributes:[:addon_id]])
	end
end
