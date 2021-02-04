class PagesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy] 
  
  def home
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        users = User.all
        format.html { redirect_to dashboard_url, notice: 'User was successfully updated.' }
        # format.json { render :index, status: :ok }
        format.json { render json: users, status: :ok } # FIXME not sure if this or above is better
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end    
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:approved)
  end
end