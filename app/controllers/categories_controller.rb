class CategoriesController < ApplicationController
   before_action :set_category, only: [:show, :edit, :update, :destroy]
   before_action :authorize_create, only: [:new]
   before_action :admin_access, only:[:show, :new, :edit, :update, :destroy]

   autocomplete :category, :name, full: true

   # GET /categories
   # GET /categories.json
   def index
      @categories = Category.paginate(:page => params[:page], :per_page => 9)
      # @categories = Category.all
   end

   def list
      @category_name = params[:name]
      render 'list'
   end

   # GET /categories/1
   # GET /categories/1.json
   def show
      @category = Category.find(params[:id])
   end

   # GET /categories/new
   def new
      #  @category = Category.new
      @category = Category.new(:parent_id => params[:parent_id])
   end

   # GET /categories/1/edit
   def edit
   end

   # POST /categories
   # POST /categories.json
   def create
      @category = Category.new(category_params)

      respond_to do |format|
         if @category.save
            format.html { redirect_to @category, notice: 'Category was successfully created.' }
            format.json { render :show, status: :created, location: @category }
         else
            format.html { render :new }
            format.json { render json: @category.errors, status: :unprocessable_entity }
         end
      end
   end

   # PATCH/PUT /categories/1
   # PATCH/PUT /categories/1.json
   def update
      @product.category_id = params[:category_id]
      respond_to do |format|
         if @category.update(category_params)
            format.html { redirect_to @category, notice: 'Category was successfully updated.' }
            format.json { render :show, status: :ok, location: @category }
         else
            format.html { render :edit }
            format.json { render json: @category.errors, status: :unprocessable_entity }
         end
      end
   end

   # DELETE /categories/1
   # DELETE /categories/1.json
   def destroy
      @category.destroy
      respond_to do |format|
         format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
         format.json { head :no_content }
      end
   end

   private
   # Use callbacks to share common setup or constraints between actions.
   def set_category
      @category = Category.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def category_params
      params.require(:category).permit(:name, :parent_id)
   end

   def authorize_create
      if !( current_user != nil)
         redirect_to '/users/sign_in', alert: 'You must be logged in first'
      end
   end
   def admin_access
      if !( current_user != nil && current_user.role == 'ADMIN')
         render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => true)
      end
   end
end
