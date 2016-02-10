class Category < ActiveRecord::Base
   include AlgoliaSearch
   algoliasearch do
      attribute :name
   end
   has_ancestry
   has_many :products, dependent: :delete_all
end
Category.reindex!
