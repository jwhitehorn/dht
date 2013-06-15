module DHT
  class Service
    def initialize(options = {})
      @explorer = options.delete(:explorer)
      @key      = options.delete(:key)
    end

    def run
      DCell::Explorer.new("127.0.0.1", 8000) if @explorer
      DHT::Storage.supervise_as :storage, @key
      DHT::Manager.supervise_as :manager
    end
  end
end

