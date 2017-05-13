require_relative 'boot'
require 'rails/all'
require 'geocoder'
require "geocoder/railtie"
require 'font-awesome-sass'
Geocoder::Railtie.insert

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MatchMe
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join("app", "assets", "font")
    config.serve_static_assets = true
    config.encoding = "utf-8"
  end
end