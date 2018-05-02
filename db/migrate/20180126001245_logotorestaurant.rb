class Logotorestaurant < ActiveRecord::Migration[5.1]
  def change
  	add_attachment :restaurants, :logo
  end
end
