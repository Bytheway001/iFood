class Addattributestoorder < ActiveRecord::Migration[5.1]
  def change
  	 add_column :orders, :change, :float, :default =>0
  	 add_column :orders, :payment_type, :string, :default =>'dinheiro'
  end
end
