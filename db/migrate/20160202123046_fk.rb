class Fk < ActiveRecord::Migration
  def change
      add_column :products, :user_id, :integer
      add_foreign_key :products, :users
  end
end
