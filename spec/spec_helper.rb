# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'faker'
require 'factory_girl'

RSpec.configure do |config|
  Kernel.srand config.seed

  config.profile_examples = 10
  config.order = :random

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
