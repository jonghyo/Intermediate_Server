/*Redisからのsubscribeを受け取り各クライアントに送信するサーバ*/

require 'rubygems'
require 'socket'
require 'eventmachine'
require 'redis'

class Subscriber < EM::Connection
  def receive_data data
    puts data
    port, host = Socket.unpack_sockaddr_in get_peername
    puts "#{host}:#{port} - #{data}"
    
    

    sub_redis = Redis.new
    sub_redis_ready = false

    subscription_thread = Thread.new do
	
       sub_redis.subscribe(data) do |on|
    	on.subscribe do
      	sub_redis_ready = true
    	end

    	  on.message do |ch, msg|
      	     p [ch, msg]
             send_datagram("Subscribe : #{msg}", host, port)
          end
       end
     end
    if data == "unsub"
	   puts "unsubscribe"
           Thread::list.each {|t| Thread::kill(t) if t != Thread::current}
           p subscription_thread.join
	   puts "Test compleated"
  end
end
end

EM::run do
  puts "Server Start..."
  EM::open_datagram_socket('0.0.0.0', 5002, Subscriber)
end

