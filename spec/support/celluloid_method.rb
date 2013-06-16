module Celluloid
  class Method
    def name
      @proxy.method_missing(:method, @name).name
    end

    def parameters
      @proxy.method_missing(:method, @name).parameters
    end

    def to_proc
      @proxy.method_missing(:method, @name).to_proc
    end
  end
end