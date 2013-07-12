require 'dht/node'

module DHT
  class Hash
    attr_reader :node

    def initialize(options = {})
      @node = DHT::Node.new(options)
      @node.start
    end

    def me
      DCell.me
    end

    def storage
      me[:storage]
    end

    def manager
      me[:manager]
    end

    def store(key, value)
      manager.storage_for(key).store(key, value)
    end

    def get(key)
      manager.storage_for(key).get(key)
    end

    def []=(key, value)
      store(key, value)
    end

    def [](key)
      get(key)
    end
  end
end