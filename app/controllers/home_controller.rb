class HomeController < ApplicationController
  def index
      @products = Product.all
      @users = User.all
  end
end
