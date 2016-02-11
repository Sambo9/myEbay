class AddCurrentPriceToProduct < ActiveRecord::Migration
  def change
     add_column :products, :current_price, :integer
  end
end
