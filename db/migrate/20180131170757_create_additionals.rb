class CreateAdditionals < ActiveRecord::Migration[5.1]
  def change
    create_table :additionals do |t|
      t.references :detail, foreign_key: true
      t.references :addon, foreign_key: true

      t.timestamps
    end
  end
end
