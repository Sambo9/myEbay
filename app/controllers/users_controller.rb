
class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
    def show
        # @user = User.find(params[:id])
        @products = Product.where(user_id: @user)
    end
    def index
        @users = User.all
    end
    def edit
        # @user = User.find(params[:id])
    end
    def update
        # @user = User.find(params[:id])
        respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    end

    def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :email, :role)
    end

    def authorize_user
        if !( current_user != nil && current_user == @user || current_user != nil && current_user.role == 'ADMIN')
            render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => true)
        end
    end

end
