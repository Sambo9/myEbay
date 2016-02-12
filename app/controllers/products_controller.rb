class ProductsController < ApplicationController
   before_action :set_product, only: [:show, :edit, :update, :destroy]
   before_action :authorize_user, only: [:edit, :update, :destroy]
   before_action :authorize_create, only: [:new]

   def index
      @p = Product.all
      if params[:search]
         @p = Product.search(params[:search]).order("created_at DESC")
      else
         @p = Product.all.order('created_at DESC')
      end
      @products = Product.paginate(:page => params[:page], :per_page => 9)
   end

   def show
      @user = User.find(@product.user_id)
      @bids = Bid.where(product_id: @product.id).order('max_bid DESC')
   end

   def new
      @product = Product.new
      @categories = Category.all
   end

   def edit
      @categories = Category.all
   end

   def create
      @product = Product.new(product_params)
      @product.current_price = @product.starting_price
      @categories = Category.all

      respond_to do |format|
         if @product.save
            format.html { redirect_to @product, notice: 'Product was successfully created.' }
            format.json { render :show, status: :created, location: @product }
         else
            format.html { render :new }
            format.json { render json: @product.errors, status: :unprocessable_entity }
         end
      end
   end

   def update
      @categories = Category.all
      respond_to do |format|
         if @product.update(product_params)
            format.html { redirect_to @product, notice: 'Product was successfully updated.' }
            format.json { render :show, status: :ok, location: @product }
         else
            format.html { render :edit }
            format.json { render json: @product.errors, status: :unprocessable_entity }
         end
      end
   end

   def destroy
      @product.destroy
      respond_to do |format|
         format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
         format.json { head :no_content }
      end
   end

   # ============================
   # ========= COMMENTS =========
   # ============================

   def add_new_comment
      @product = Product.find(params[:id])
      comment = @product.comments.create
      comment.comment = params[:comment]
      comment.user_id = current_user.id
      comment.save
      redirect_to :action => :show, :id => @product
   end

   # ========================
   # ========= BIDS =========
   # ========================

   def add_new_bid
      @product = Product.find(params[:id])
      bid = Bid.create

      if params[:max_bid].to_i >= @product.price
         respond_to do |format|
            format.html { redirect_to @product, notice: 'Purchased' }
            format.json { render :show, status: :ok, location: @product }
         end
      elsif params[:max_bid].to_i < @product.current_price
         respond_to do |format|
            format.html { redirect_to @product, alert: 'Your bid must be higher than the starting price !' }
            format.json { render :show, status: :ok, location: @product }
         end
      else
         bid.max_bid = params[:max_bid]
         bid.product_id = @product.id
         bid.user_id = current_user.id
         bid.save
         respond_to do |format|
            format.html { redirect_to @product, notice: 'Your bid has been placed' }
            format.json { render :show, status: :ok, location: @product }
         end
      end
   end

   private
   def set_product
      begin
         @product = Product.find(params[:id])
      rescue
         render(:file => File.join(Rails.root, 'public/404.html'), :status => 404, :layout => true)
      end
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def product_params
      params.require(:product).permit(:title, :description, :price, :category_id, :starting_price, :end_date).merge(:user_id => current_user.id);
   end

   def authorize_user
      if !( current_user != nil && current_user.id == @product.user_id || current_user != nil && current_user.role == 'ADMIN')
         render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => true)
      end
   end
   def authorize_create
      if !( current_user != nil)
         redirect_to '/users/sign_in', alert: 'You must be logged in first'
      end
   end
end
