class Product < ActiveRecord::Base
   ratyrate_rateable "product"
   belongs_to :user
   validates :user, presence: true

   validates :title, length: {in: 3..50}
   validates :price, numericality: {greater_than: 0}
   validates :description, :presence => true, :length => {minimum: 2}, :allow_blank => true
   validates :user_id, numericality: {greater_than: 0}, presence: true
end
