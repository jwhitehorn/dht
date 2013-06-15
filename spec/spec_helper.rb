$LOAD_PATH << File.dirname(__FILE__) + '/..'

require 'rspec'
require 'dht/hash'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
