class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_no_cache

  protected

  # Prevent browser caching
  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  # Redirect to login if the user is not authenticated
  def authenticate_user!
    if doctor_signed_in?
      super
    else
      redirect_to new_doctor_session_path
    end
  end
end
