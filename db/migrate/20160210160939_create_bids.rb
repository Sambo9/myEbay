class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :starting_price
      t.integer :current_bid
      t.integer :max_bid
      t.datetime :end_date
      t.references :product, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
