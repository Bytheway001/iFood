class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :cep, :integer
  	add_column :users, :lat, :float
  	add_column :users, :long, :float
  end
end
