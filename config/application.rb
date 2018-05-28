require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative '../lib/ext/kernel'
require_relative '../lib/ext/hash'

alias :apply :yield_self

module Bugmark
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    tpath = "/etc/timezone"
    config.time_zone = File.exist?(tpath) ? File.read(tpath).chomp : "Pacific Time (US & Canada)"

    config.paths.add File.join('app', 'api'), glob: File.join("**", "*.rb")

    base = "#{config.root}/app"
    config.autoload_paths += %W(#{base}/commands)
    config.autoload_paths += %W(#{base}/libs)
    config.autoload_paths += %W(#{base}/api)
    config.autoload_paths += %W(#{base}/queries)

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins  '*'
        resource '*', :headers => :any, :methods => %i(get post options)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
