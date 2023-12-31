require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PropertyListing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.google_maps_api_key = ENV['GOOGLE_MAPS_API_KEY']
    EasyTranslate.api_key = ENV['GOOGLE_TRANSLATION_API_KEY']
    Globalize.fallbacks = { en: [:en, :id], id: [:id, :en] }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
