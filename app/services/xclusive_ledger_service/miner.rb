module XclusiveLedgerService

  class Miner
    
    class << self 
      include XclusiveLedgerService::Hashing

      def mine_pending_transactions
        begin
          pending_transactions = Transaction.where(status: "pending")
          prev_block_hash = XclusiveLedgerBlock.last.hash
          block = XclusiveLedgerBlock.create_new(pending_transactions, prev_block_hash)
          mine(block)
          Transaction.where(id: pending_transactions.pluck(:id)).delete_all
        rescue Exception => error
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
          mining_print_message = '==== Mining transactions: ' + block.hash + " ===="
          print "#{mining_print_message}\r"
        end
        puts "Block Hash: #{block.hash}"
        puts "Nonce: #{block.nonce}"
        block.update_hash_and_nonce(block.hash, block.nonce)
      end
  
    end

  end

end