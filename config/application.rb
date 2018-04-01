require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ZealHealthcareSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Sets Devise layouts
    config.to_prepare do
	    Devise::SessionsController.layout "landing_page"
	    Devise::RegistrationsController.layout "landing_page"
	    Devise::ConfirmationsController.layout "landing_page"
	    Devise::UnlocksController.layout "landing_page"
	    Devise::PasswordsController.layout "landing_page"
	end
  end
end
