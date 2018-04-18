module Auditor
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper Rails.application.routes.url_helpers
    layout 'layouts/application'
  end
end
