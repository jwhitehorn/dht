$LOAD_PATH << File.dirname(__FILE__) + '/..'

require 'rspec'
require 'bogus/rspec'
require 'dht/hash'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  #config.before(:suite) do
  #  DCell.setup
  #  DCell.run!
  #end
end

Bogus.configure do |c|
  c.search_modules << DHT
end