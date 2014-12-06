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

    ActiveRecord::Base.send(:extend, Util::ConcernedWith)
  end
end
