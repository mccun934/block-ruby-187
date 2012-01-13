require 'socket'                	
clientcount = 0
server = TCPServer.open(5599)
loop {
  Thread.start(server.accept) do |client|
	clientcount = clientcount + 1
    client.puts(clientcount)
    sleep 1
    if clientcount == 5
      puts "clientcount 5, Start writing to a file"
      f = File.new('/dev/null', 'a')
      # Write a roughly 400MB file to /dev/null
      # Takes generally from 5-30 seconds
      #
      # At this point when the server is writing the file any *new* clients
      # that connect to this server will get no response and will have to wait
      # for this output to finish.
      linelimit = 30000000
      for i in 0..linelimit
        f.puts "Hello, world."
      end
      f.close
    end
    client.close
  end
}
