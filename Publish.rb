require 'rubygems'
require 'socket'
require 'eventmachine'
require 'redis'

class Receiver < EM::Connection
  def receive_data data
    puts data
    pubdata = data.split(",")
    puts pubdata
    port, host = Socket.unpack_sockaddr_in get_peername
    puts "#{host}:#{port} - #{data}"
    redis = Redis.new
    redis.publish pubdata[0], pubdata[1]
    send_datagram("echo> #{data}", host, port)
  end
end

EM::run do
  puts "Server Start..."
  EM::open_datagram_socket('0.0.0.0', 5000, Receiver)
end

