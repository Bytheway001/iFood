class Users::OrdersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@order=current_user.orders.where(:status =>0).order(created_at: :asc).first
		if @order
			redirect_to [:users,@order]
		end
	end

	def show
		@order=Order.find(params[:id])
		n=@order.notifications.first
		n.update_attributes(:read=>true)
		n.save
	end

	def ready
		@order=Order.find(params[:order_id])
		@order.update_attributes(:status=>2)
		redirect_to users_orders_path
	end
end