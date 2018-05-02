class AddApellidoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :apellido, :string
  end
end
