class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
    t.string :nombre
    t.string :telefono
    t.string :direccion
    t.string :email
    t.references :user
       t.timestamps
    end
  end
end
