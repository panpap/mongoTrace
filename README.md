mongoTrace
==========

Ruby script that dispatch packet fields from a trace and stores them in a mongoDB.

###Dependencies
It needs the following gems:
  1. [mongo][]
  2. [bson_ext][]
  
It also needs a mongoDB server running in default localhost and port

###Usage
  `ruby mongoTrace.rb <trace>`

[bson_ext]: https://rubygems.org/gems/bson_ext
[mongo]: https://rubygems.org/gems/mongo‎
