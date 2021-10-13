module XclusiveLedgerService

  class Miner
    
    class << self 
      include Hashing

      def mine_pending_transactions
        begin
          pending_transactions = Transaction.where(status: "pending")
          prev_block_hash = XclusiveLedgerBlock.last.hash
          block = XclusiveLedgerBlock.new(transactions: pending_transactions, previous_block_hash: prev_block_hash)
          mine(block)
          block.save
          Transaction.where(id: pending_transactions.pluck(:id)).delete_all
        rescue Exception => error
          byebug
          # puts error 
          # puts error.backtrace
          Transaction.where(id: pending_transactions.pluck(:id)).delete_all
        end
      end
  
      def mine(block)
        block.nonce = 0
        while !valid_hash?(block.hash)
          block.nonce = block.nonce + 1
          block.hash = calculate_hash(block)
          print "#{block.hash}\r"
        end
      end
  
    end

  end

end