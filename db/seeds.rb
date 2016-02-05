# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



1.times do |n|
  title  = Faker::Commerce.product_name
  description = Faker::Commerce.product_name + " " + Faker::Commerce.department(5)
  price = Faker::Commerce.price
  image = "http://loremflickr.com/399/399?random="+rand(1..99).to_s
  user_id = rand(12..29)
  Product.create!(title:  title,
            description: description,
            price: price,
               image: image,
               user_id: user_id)
end
