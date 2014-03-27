#
#	Panagiotis Papadopoulos
#	trace analyzer and dispatcher for mongoDB. uses tcpdump
#


require 'mongo'
include Mongo

def getIfExists(line,search)
	res=""
	temp=line.split(search+" ")[1]
	if temp==nil
		return res
	end
	if search.eql? "options"
		res="["+temp.split("[")[1].split("]")[0]+"]"
	else
		if line.include? search
			res=line.split(search+" ")[1].split(",")[0]
		end
	end
	return res
end


if ARGV.size==0
	puts "> Not enough arguments! Aborting..."
	abort
end
host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
port = ENV['MONGO_RUBY_DRIVER_PORT'] || MongoClient::DEFAULT_PORT
puts "Connecting to #{host}:#{port}"
db = MongoClient.new(host, port).db('tcpdump')
filename=ARGV[0].split('.')[0]
db.drop_collection('trace_'+filename)
coll = db.create_collection('trace_'+filename)
system("tcpdump -n -r "+ARGV[0]+" tcp > .temp")	
f=File.new('.temp')
count=0
begin
while line=f.gets do
	count+=1
	line=line.chop
	part=line.split(" ");
	seq=getIfExists(line,"seq")
	ack=getIfExists(line,"ack")
	length=getIfExists(line,"length")
	win=getIfExists(line,"win")
	flags=getIfExists(line,"Flags")
	options=getIfExists(line,"options")
	temp=part[2].rpartition(".")
	srcIP=temp[0]
	srcPort=temp[2]
	temp=part[4].rpartition(".")
	dstIP=temp[0]
	dstPort=temp[2]	
	coll.insert('time'=>part[0],'srcIP'=>srcIP,'dstIP'=>dstIP,'srcPort'=>srcPort,'dstPort'=>dstPort,'flags'=>flags,'seq'=>seq,'ack'=>ack,'win'=>win,'length'=>length,'options'=>options)
end
rescue Exception => e 
	puts e.message  
	puts e.backtrace.inspect  
	puts "Rescued from exception"
end
f.close
puts "TOTAL: "+count.to_s+" packets"
system("rm -f .temp")
