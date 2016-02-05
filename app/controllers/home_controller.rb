class HomeController < ApplicationController
  def index
     @products = Product.order('created_at DESC').limit(9)
     @users = User.all
  end
end
