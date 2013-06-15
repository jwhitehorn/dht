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

    def []=(key, value)
      manager.store(key, value)
    end

    def [](key)
      manager.get(key)
    end
  end
end