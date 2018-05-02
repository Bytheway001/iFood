ActiveAdmin.register Restaurant do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :user_id,:telefono,:email,:status	
show  :title=>proc {|restaurant| restaurant.nombre } do
	panel "Orders" do
		table_for restaurant.orders do |c|
			column :id
			column :created_at do |u|
				u.created_at.strftime("%d-%m-%y")
			end
			column :user do |u|
				u.user.nombre
			end
			column :total_price

		end
	end
end
sidebar 'Información', only: :show do
	attributes_table_for restaurant do
		row :nombre
		row :email
		row :user 
		row :telefono
		row :status
	end
end

index do
	column :id
	column :logo do |r|
		image_tag r.logo(:avatar)
	end
	column :nombre do |n|
		link_to n.nombre, admin_restaurant_path(n)
	end
	column :user
	column :telefono
end

form do |f|
	f.semantic_errors
	f.inputs 'Restaurant' do 
		f.input :user,:label=>'Dueño', :as => :select, :collection => User.all.collect {|user| [user.email, user.id] }
		f.input :telefono
		f.input :email
		f.input :status, :as=>:select, :collection=>['activo','suspendido','en espera'],input_html: {:class=>'form-control input-sm' }
	end
	f.actions
end

end
