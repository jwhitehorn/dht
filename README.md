DHT
===

[![Build Status](https://secure.travis-ci.org/LTe/dht.png)](http://travis-ci.org/LTe/dht)
[![Dependency Status](https://gemnasium.com/LTe/dht.png)](https://gemnasium.com/LTe/dht)
[![Code Climate](https://codeclimate.com/github/LTe/dht.png)](https://codeclimate.com/github/LTe/dht)
[![Coverage Status](https://coveralls.io/repos/LTe/dht/badge.png?branch=master)](https://coveralls.io/r/LTe/dht?branch=master)
[![Gem Version](https://badge.fury.io/rb/dht.png)](http://badge.fury.io/rb/dht)

A Ruby implementation of a Distributed Hash Table.

Basic usage
===========

You can create instance of `DHT::Hash` and use like normal `Hash`

```ruby
require 'dht/hash'

hash = DHT::Hash.new
hash[:key] = :value # => :value
hash[:key] # => :value
```

Advanced usage
==============

You can create instance of `DHT::Hash` with few options

* **host** - your IP address or domain
* **port** - your open port where DHT::Hash will be listen
* **name** - name of your node
* **node** - bootstrap node

```ruby
require 'dht/hash'

hash = DHT::Hash.new :host => "mydomain.com" # default 127.0.0.1
                     :port => 8080 # default 3000
                     :name => "my_name" # default "node"
                     :node => { :id => "bootstrap", :addr => 'tcp://domain.com:2042' } # boostrap node
                     :explorer => true # enable explorer
```



