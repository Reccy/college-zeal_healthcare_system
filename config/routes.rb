Rails.application.routes.draw do
  
  # Devise setup
  devise_for :doctors, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, :controllers => { registrations: 'registrations' }
  
  # Landing Page / Root route
  get '/', to: 'landing_page#view'

  # Medical Facility routes
  resources :medical_facility, path: '/facilities'

end
