class CreateAddons < ActiveRecord::Migration[5.1]
  def change
    create_table :addons do |t|
      t.references :dish, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
