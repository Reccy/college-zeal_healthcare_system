Rails.application.routes.draw do
  devise_for :doctors, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, :controllers => { registrations: 'registrations' }
  get '/', to: 'landing_page#view'
  get '/facilities', to: 'medical_facility#index'
end
