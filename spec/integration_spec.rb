require 'spec_helper'

describe "integration specs" do
  before(:all) do
    Redis.new.flushall
    @test_node = TestNode.new
    @test_node.spawn
    @hash = DHT::Hash.new
  end

  after(:all) do
    @test_node.stop
  end

  it "recognize another node" do
    @hash.manager.nodes.count.should == 2
  end

  it "saves key and value in current node" do
    @hash[:key_100] = :value_100

    @hash.storage.database.should include(:key_100 => :value_100)
    @hash[:key_100].should == :value_100
  end

  it "saves key and value in another node" do
    @hash[:key_101] = :value_101

    @hash.storage.database.should_not include(:key_101 => :value_101)
    @hash[:key_101].should == :value_101
  end

  it "replaces value in network" do
    @hash[:key_101] = :value_101
    @hash[:key_101] = :changed

    @hash[:key_101].should == :changed
  end


end
