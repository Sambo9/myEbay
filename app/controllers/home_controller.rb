class HomeController < ApplicationController
  def index
     @products = Product.paginate(:page => params[:page], :per_page => 9).order('created_at DESC')
     @users = User.all
  end
end
