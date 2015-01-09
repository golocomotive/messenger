require 'haml'
require 'hashie/mash'
require 'activerecord-import'
require_relative '../util/concerned_with'

module Messenger
  class Railtie < Rails::Railtie
    root = Messenger.root.to_s

    generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        app.config.paths['db/migrate'] << File.join(root, 'db/migrate')
      end
    end

    initializer :define_sender_model_name do |app|
      config_file   = File.join app.root, 'config/messenger.yml'
      configuration = YAML.load_file(config_file) if File.exists?(config_file)
      configuration = Hashie::Mash.new(configuration || {})
      app.config.sender_model_name = configuration.sender_model || 'User'
    end

    ActiveRecord::Base.send(:extend, Util::ConcernedWith)
  end
end
