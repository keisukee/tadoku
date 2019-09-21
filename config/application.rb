require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppName
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.sass.preferred_syntax = :sass
    config.generators do |g|
      g.stylesheets :sass
      g.javascripts false
      g.helper false
      g.template_engine :slim
      g.test_framework :rspec, view_specs: false, helper_specs: false, fixture: true
      # g.fixture_replacement :factory_girl, dir: "spec/support/factories"
    end

    config.autoload_paths += %W(#{config.root}/lib) # add this line
  end
end
