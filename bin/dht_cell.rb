#!/usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__)+'/..' << File.dirname(__FILE__)+'/../lib'

require 'irb'
require 'dcell'
require 'dht/node'
require 'optparse'

options = {}

opts = OptionParser.new do |opts|
  opts.banner = "Usage: dht_dcell.rb [options]"

  opts.on("-n", "--name [NAME]", String, "Select node name") do |name|
    options[:name] = name
  end

  opts.on("-p", "--port [PORT]", String, "Select node port") do |port|
    options[:port] = port.to_i
  end

  opts.on("-h", "--host [HOST]", String, "Select node host") do |host|
    options[:host] = host
  end

  opts.on("-n", "--node [NODE]", String, "One of nodes: name:host:port") do |node|
    if node
      node_attributes = node.split(":")
      options[:node] = { :id => node_attributes[0], :addr => "tcp://#{node_attributes[1]}:#{node_attributes[2]}" }
    end
  end

  opts.on("-e", "--explorer") do |explorer|
    options[:explorer] = explorer
  end
end

opts.parse!

node = DHT::Node.new(options)
node.start

ARGV.clear
IRB.start


