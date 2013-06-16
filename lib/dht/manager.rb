require 'celluloid'

module DHT
  class Manager
    include Celluloid

    attr_reader :nodes

    def initialize
      @nodes = find_nodes
    end

    def find_nodes
      DCell::Node.all.inject({}) { |hash, node| hash[node[:storage].key] = node; hash }
    end

    def store(key, value)
      closest_node = node_for(key)

      if closest_node == me
        me[:storage].store(key, value)
      else
        closest_node[:manager].store(key, value)
      end
    end

    def get(key)
      closest_node = node_for(key)

      if value = me[:storage][key]
        value
      elsif closest_node == me
        "There is no such key (#{key})"
      else
        closest_node[:manager].get(key)
      end
    end

    def node_for(key)
      key       = Key.for_content(key.to_s)
      node_key  = @nodes.keys.min { |a,b| a.distance_to(key) <=> b.distance_to(key) }
      nodes[node_key]
    end

    def key
      Key.for_content(me.addr)
    end

    private

    def me
      DCell.me
    end
  end
end