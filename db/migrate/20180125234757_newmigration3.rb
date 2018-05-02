class Newmigration3 < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :failed_attempts, :integer
  end
end
