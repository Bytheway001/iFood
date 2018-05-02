class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :users, :apellido, :direccion
  end
end
