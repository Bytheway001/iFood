json.notifications @notifications do |notification|
	json.id notification.order.id
	json.user notification.order.user.email
	json.restaurant notification.order.restaurant.nombre
	json.fecha notification.order.created_at.strftime('%d-%m-%y')
end