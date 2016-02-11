class AddColProduct < ActiveRecord::Migration
  def change
     add_column :products, :end_date, :datetime
     add_column :products, :starting_price, :integer
  end
end
