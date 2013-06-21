require 'bbq/spawn'

class TestNode
  include Bbq::Spawn

  def initialize(options = {})
    @port = options.delete(:port) || "3002"
  end

  def spawn
    orchestrator.start
  end

  def stop
    orchestrator.stop
  end

  private

  def executable
    File.expand_path("../../../bin/dht_cell.rb", __FILE__)
  end

  def executor
    Executor.new("bundle", "exec", "ruby", executable, "--port", @port, "--name", "node")
  end

  def orchestrator
    @orchestrator ||= Orchestrator.new.tap do |orchestrator|
      orchestrator.coordinate(executor, :host => "127.0.0.1", :port => @port)
    end
  end
end