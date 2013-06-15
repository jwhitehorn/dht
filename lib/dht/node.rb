require 'set'
require 'celluloid'
require 'dcell/explorer'
require 'dht/key'
require 'dht/storage'
require 'dht/manager'
require 'dht/service'

module DHT
  class Node
    def initialize(options = {})
      options = default_options.merge(options)
      @host = options.delete(:host)
      @port = options.delete(:port)
      @name = options.delete(:name)
      @node = options.delete(:node)
      @explorer = options.delete(:explorer)
    end

    def start
      DCell.start(configuration)
      DHT::Service.new(:key => key, :explorer => @explorer).run
    end

    def configuration
      configuration = {:id => @name, :addr => "tcp://#{@host}:#{@port}"}
      configuration.merge!(:directory => @node) if @node

      configuration
    end

    def key
      @key ||= Key.for_content("#{@name}:#{@host}:#{@port}")
    end

    private

    def default_options
      {
        :name => "default",
        :port => 3000,
        :host => "127.0.0.1"
      }
    end
  end
end
