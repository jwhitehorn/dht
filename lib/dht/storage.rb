require 'celluloid'

module DHT
  class Storage
    include Celluloid

    attr_reader :key, :database

    def initialize(key)
      @key      = key
      @database = {}
    end

    def store(key, value)
      @database[key] = value
    end

    def get(key)
      @database[key]
    end

    def [](key)
      get(key)
    end

    def []=(key, value)
      store(key, value)
    end
  end
end