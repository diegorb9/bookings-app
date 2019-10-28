# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookingApp
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = 'pt-BR'
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.generators do |g|
      g.template_engine nil
      g.test_framework  nil
      g.assets false
      g.helper false
      g.stylesheets false
    end
  end
end
