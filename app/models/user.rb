
class User < ActiveRecord::Base
   include AlgoliaSearch
   algoliasearch do
      attribute :first_name, :last_name, :email, :address
   end
   ratyrate_rater
   ratyrate_rateable "user"
   acts_as_commentable
   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   has_many :products, dependent: :destroy

   devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable

   validates_presence_of :last_name, :first_name, :email

end
User.reindex!
