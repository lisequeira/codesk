class UsersController < ApplicationController

  before_action :set_space, only: [ :show, :edit, :update]

  def show
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def edit
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :city, :birth_date)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

end
