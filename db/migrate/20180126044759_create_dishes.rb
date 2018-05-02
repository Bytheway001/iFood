class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.references :restaurant, foreign_key: true
      t.string :nombre
      t.string :descripcion
      t.float :precio
      t.boolean :active

      t.timestamps
    end
    add_attachment :dishes, :photo
  end
end
