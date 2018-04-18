Rails.application.routes.draw do
  mount Auditor::Engine => "/auditor"
end
