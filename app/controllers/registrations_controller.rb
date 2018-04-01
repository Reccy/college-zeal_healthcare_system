class RegistrationsController < Devise::RegistrationsController
  # This controller is used to ensure Doctor registration works with the added fields not native to the devise gem.
  # Source: https://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html

  private

  def sign_up_params
    params.require(:doctor).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:doctor).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end