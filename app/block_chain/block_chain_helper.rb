module BlockChainHelper

  def every(seconds)
    Thread.new do
      loop do
        sleep seconds
        yield
      end
    end
  end


  def gossip_with_peer(port)

  end
end