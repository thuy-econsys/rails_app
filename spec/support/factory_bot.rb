# access FactoryBot build and create helper methods w/o prefixing FactoryBot.
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
