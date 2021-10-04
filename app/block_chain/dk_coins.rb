class DkCoins

    attr_reader :block_chain
    def initialize
      @block_chain = BlockChain.new
    end

    def create_transactions
      puts "======== Adding transaction 1 ============="
      @block_chain.add_block({a:10})
      puts "======== Adding transaction 2 ============="
      @block_chain.add_block({b:10})
      puts "======== Adding transaction 3 ============="
      @block_chain.add_block({c:10})
    end

    def print_transactions 
      puts JSON.pretty_generate @block_chain.chain.map(&:instance_values)
    end

    def validate
      unless @block_chain.valid?
        raise ActiveModel::ValidationError.new(@block_chain)
      end
    end

    def test 
      create_transactions
      print_transactions
    end

    private
    attr_writer :block_chain

end
