class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :order, foreign_key: true
      t.boolean :read
      t.timestamps
    end
  end
end
