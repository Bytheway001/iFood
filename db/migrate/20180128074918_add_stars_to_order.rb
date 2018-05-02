class AddStarsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :stars, :integer,:default => 0
  end
end
