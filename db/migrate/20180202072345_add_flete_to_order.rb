class AddFleteToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :flete, :float
    add_column :orders, :driver_id, :integer
  end
end
