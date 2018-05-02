# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

#0.- Guardamos el usuario

# 1.- Limpiamos TODO!
User.where('email not in (?)','bytheway0708@gmail.com').destroy_all
User.find_by_email('bytheway0708@gmail.com').update_attributes(:id=>1)
puts ('Users destroyed')
Restaurant.destroy_all
puts ('Restaurants destroyed')
puts("Usuario inicial creado")
3.times do |x|
	User.create!(
		email:Faker::Internet.email,
		password: 'Silvereye1990',
		password_confirmation:'Silvereye1990',
		lat: -8.7621588,
		long: -63.871978600000034,
		nombre: Faker::Name.name,
		direccion: "Rua Pastor Eurico Alfredo Nelson #1118",
		cep: 76820206
		)
	puts ("Creating Users: "+x.to_s+'/10')

end
puts "All users created... making Restaurants"

User.all.each_with_index do |user,index|
	3.times do |x|
		user.restaurants.create!(
			nombre:Faker::Company.name,
			telefono:Faker::PhoneNumber.phone_number,
			direccion:Faker::Address.street_address,
			email:Faker::Internet.email,
			logo: File.new("C:/Users/Rafael/Desktop/images/subway.jpg")
			)
		puts("Creating Restaurants: "+x.to_s+'/10 for user '+index.to_s+' of 11')
	end
end

puts "Restaurants done.... proceeding with orders"

Restaurant.all.each do |restaurant|
	puts "Generating data for restaurant:"+restaurant.nombre
	3.times do |d|
		puts "Adding dish number"+d.to_s
		dish=restaurant.dishes.new(
			:nombre=>Faker::Food.dish,
			:descripcion=>Faker::Food.ingredient,
			:precio=>Faker::Number.decimal(2,2),
			:photo=>File.new("C:/Users/Rafael/Desktop/images/Lanchonete img/Big Mac.jpg")
		)
		dish.save!
		
	end
	3.times do |order|
		puts "Adding order nuber"+order.to_s
		o=restaurant.orders.new(
			:user_id=>User.order("RANDOM()").first.id,
			:change=>100,
			:payment_type=>'dinheiro',
		)
		o.save!
	end
	
	restaurant.orders.each do |order|
		puts "Adding details"
		d=order.details.new(
			:qty=>Faker::Number.number(1),
			:dish_id=>restaurant.dishes.order("RANDOM()").first.id,
			:comment=>Faker::HowIMetYourMother.quote
		)
		d.save!
	end
end

