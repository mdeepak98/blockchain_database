module XclusiveLedgerService
  
  class Initializer
    
    def self.init
      return if XclusiveLedgerBlock.count > 0
      create_genesis_block()
      add_initial_transactions()
      Miner.mine_pending_transactions()
    end
    
    def self.create_genesis_block
      begin   
        block = new(transactions: [], previous_block_hash: "GENESIS BLOCK")
        Miner.mine(block)
        block.save
      rescue Exception => error
        # puts error 
        # puts error.backtrace
      end
    end

    def self.add_initial_transactions
      Transaction.create(from_address: 'System', to_address: 'Caratlane', amount: 4_000)
      Transaction.create(from_address: 'Caratlane', to_address: 'User1', amount: 1_000)
      Transaction.create(from_address: 'User1', to_address: 'User2', amount: 2_00)
      Transaction.create(from_address: 'User2', to_address: 'User3', amount: 50)        
    end

  end

end