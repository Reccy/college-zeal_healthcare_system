Rails.application.routes.draw do
  
  # Devise setup
  devise_for :doctors, except: [:show], path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, :controllers => { registrations: 'registrations' }
  
  # Landing Page / Root route
  get '/', to: 'landing_page#view', as: :root_path

  # Medical Facility routes
  resources :medical_facility, only: [:index, :create, :edit, :update, :show, :destroy], path: '/facilities' do
  	get :remove_facility_head
  	post :assign_facility_head
  	post :search_doctors

    resources :department, only: [:create, :show] do
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

  # Patient routes
  resources :patients, only: [:index, :show, :create] do
    patch :assign_doctor

    resources :patient_records, only: [:create] do
      patch :archive_record
    end
  end
end
