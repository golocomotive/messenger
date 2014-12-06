require 'hashie/mash'
require_relative '../util/concerned_with'

module Messenger
  class Engine < ::Rails::Engine
    isolate_namespace Messenger

    config.autoload_paths += %W(#{root}/lib)

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
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
