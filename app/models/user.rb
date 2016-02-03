
class User < ActiveRecord::Base
    ratyrate_rater
    ratyrate_rateable "user"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :products, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates_presence_of :last_name, :first_name, :email

end
