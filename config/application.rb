require_relative 'boot'

require 'rails/all'
require_relative '../lib/authenticate_user_request'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Meetup
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.middleware.use AuthenticateUserRequest
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
