module BlockChainConnection

  $PEER_PORTS = []

  def connect_with_peers
    every(3.seconds) do
      $PEERS.dup.each do |port|
        next if port == PORT
    
        puts "Gossiping about blockchain and peers with #{port.to_s.green}"
        gossip_with_peer(port)
      end
    end
  end
end