require 'socket'

hostname = 'localhost'
port = 5599
loop {
    s = TCPSocket.open(hostname, port)
    while line = s.gets
      puts line.chop
    end
    s.close
}
