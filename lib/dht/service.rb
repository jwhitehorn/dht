module DHT
  class Service
    def initialize(options = {})
      @explorer = options.delete(:explorer)
      @key      = options.delete(:key)
    end

    def run
      run_services
    end

    def run_services
      create_explorer if enable_explorer?
      create_storage
      create_manager
    end

    def create_explorer
      DCell::Explorer.new("127.0.0.1", 8000)
    end

    def create_storage
      DHT::Storage.supervise_as :storage, @key
    end

    def create_manager
      DHT::Manager.supervise_as :manager
    end

    private

    def enable_explorer?
      @explorer
    end
  end
end

