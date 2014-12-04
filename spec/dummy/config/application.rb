require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(*Rails.groups)

require 'messenger'

module Dummy
  class Application < Rails::Application
    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]

    config.generators do |g|
      g.test_framework :rspec
      g.integration_tool :rspec
    end
  end
end
