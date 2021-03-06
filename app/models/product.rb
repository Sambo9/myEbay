class Product < ActiveRecord::Base
   include AlgoliaSearch
   algoliasearch do
      attribute :title, :description, :price
   end
   is_impressionable
   ratyrate_rateable "product"
   belongs_to :user
   validates :user, presence: true
   belongs_to :category
   acts_as_commentable

   validates :title, length: {in: 3..50}
   validates :price, numericality: {greater_than: 0}
   validates :description, :presence => true, :length => {minimum: 2}, :allow_blank => true
   validates :user_id, numericality: {greater_than: 0}, presence: true
   validates :category_id, presence: true

end
Product.reindex!
