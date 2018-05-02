class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
      t.references :order, foreign_key: true
      t.references :dish, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end
