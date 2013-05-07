Intermediate_Server
====================

This is Intermediate Server between KVS Redis and Clients.

It incarnate Publish/Subscribe system.


1. receiver.rb
   It is Publish server.
   it receives some message from client and it sends redis to use "publish" method. 

2. sendclient.rb
   It is client to send message 'receiver.rb'.
  when you debug 'reciever.rb', you have to use it.

3. Subscribe.rb
   It is Subscribe server.
   it receives subscribe message from Redis and sends it to client. 
