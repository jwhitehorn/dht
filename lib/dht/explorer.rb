module DHT
  class Explorer < DCell::Explorer
    ASSET_ROOT = Pathname.new File.expand_path("../../explorer", __FILE__)

    def initialize(host = "127.0.0.1", port = 7778)
      super(host, port, &method(:on_connection))
    end
  end
end