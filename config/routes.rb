Rails.application.routes.draw do
  
  # Devise setup
  devise_for :doctors, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, :controllers => { registrations: 'registrations' }
  
  # Landing Page / Root route
  get '/', to: 'landing_page#view', as: :root_path

  # Medical Facility routes
  resources :medical_facility, path: '/facilities' do
  	get :remove_facility_head
  	post :assign_facility_head
  	post :search_doctors

    resources :department do
      get :remove_department_head
      post :assign_department_head
      post :hire

      resources :doctors, only: [] do
        get :fire
      end
    end
  end

  # Doctor routes
  resources :doctors, only: [:show]
end
