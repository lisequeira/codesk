class RegistrationsController < Devise::RegistrationsController


  protected

  def after_update_path_for(resource)
    root_path
  end




  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :photo, :photo_cache)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :city, :password, :password_confirmation, :current_password, :photo)
  end


end
