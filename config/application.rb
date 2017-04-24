require_relative 'boot'
require 'rails/all'
require 'geocoder'
require "geocoder/railtie"
<<<<<<< HEAD
require 'font-awesome-sass'
=======

>>>>>>> cce9b6b2282a62ac6583be1acefb9d2bb4265ff2
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
  end
end