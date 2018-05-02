class AddStatustoRestaurant < ActiveRecord::Migration[5.1]
  def change
  	 add_column :restaurants, :status, :string,:default=>"activo"
  end
end
