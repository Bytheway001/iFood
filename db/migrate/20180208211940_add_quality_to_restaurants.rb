class AddQualityToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :quality, :integer
  end
end
