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
    # Make UTF-8 the default
    Encoding.default_internal, Encoding.default_external = ['utf-8'] * 2
    config.assets.paths << Rails.root.join("app", "assets", "font")
    config.serve_static_assets = true
  end
end