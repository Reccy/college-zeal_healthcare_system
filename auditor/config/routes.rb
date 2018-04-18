Auditor::Engine.routes.draw do
	resources :audits, only: [:index, :create]
end
