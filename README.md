mongoTrace
==========

Ruby script that dispatch packet fields from a trace and stores them in a mongoDB.

###Dependencies
It needs the following gems:
  1. [mongo][]
  2. [bson_ext][]
  
It also needs a mongoDB server running in default localhost and port

###Usage
  You can open a terminal and type the following command:
  
  
  `ruby mongoTrace.rb <trace>`
  
  
  "<trace>" is the path of the pcap file that you want to dispatch its packets

[bson_ext]: https://rubygems.org/gems/bson_ext
[mongo]: https://rubygems.org/gems/mongo‎
