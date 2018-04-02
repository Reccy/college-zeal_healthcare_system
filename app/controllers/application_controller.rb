class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  # Redirect to login if the user is not authenticated
  def authenticate_user!
    if doctor_signed_in?
      super
    else
      redirect_to new_doctor_session_path
    end
  end
end
