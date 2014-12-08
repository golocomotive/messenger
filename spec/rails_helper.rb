ENV['RAILS_ENV'] ||= 'test'

require 'active_support/all'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'database_cleaner'
require 'shoulda/matchers'
require File.expand_path('../dummy/spec/factories/users', __FILE__)

Dir[File.join(File.expand_path('../rails_support', __FILE__), '/**/*.rb')].each { |f| puts f; require f }

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    FactoryGirl.lint
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
