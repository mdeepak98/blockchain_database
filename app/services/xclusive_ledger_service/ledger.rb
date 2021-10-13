module XclusiveLedgerService

  class Ledger
    include XclusiveLedgerConstants
    include ActionView::Helpers::DateHelper
  
    def add_block(transactions)
      new_block = XclusiveLedgerBlock.new(transactions: transactions, previous_hash: XclusiveLedgerBlock.last.hash)
      new_block.mine(MINING_DIFFICULTY)
      new_block.save
    end
  
    def calculate_balance(address)
      # check if adding new block by taking amount from my block and adding to my block can be an attack. from and to both are my address
      balance = 0
      XclusiveLedgerBlock.all.each do |block|
        block.transactions.each do |transaction|
          balance += transaction.amount if transaction.to_address == address
          balance -= transaction.amount if transaction.from_address == address
        end
      end
      balance
    end
  
    def self.world_state
      state = {}
      XclusiveLedgerBlock.all.each do |block|
        block.transactions.each do |transaction|
          transaction = Transaction.new(transaction)
          state[transaction.from_address] = (state[transaction.from_address] || 0) - transaction.amount if transaction.from_address.present?
          state[transaction.to_address] = (state[transaction.to_address] || 0) + transaction.amount 
        end
      end
      state
    end
  
    def present?
      @chain.present? && @chain.length > 1
    end

    def self.current_state
      world_state.map{|username, amount| 
        {username: username, xclusive_points: amount} if username != "System"
      }.compact
    end
  
    def self.history 
      blocks = XclusiveLedgerBlock.all
      return [] if blocks.length < 2
      blocks[1..-1].map{|block| 
        block.transactions.map{|txn| 
          if txn["from_address"] == "System"
            message = "System added #{txn['amount']} points to #{txn['to_address']}"
          else 
            message = "#{txn['from_address']} sent #{txn['amount']} points to #{txn['to_address']}"
          end
          { 
            id: txn["id"], 
            message: message, 
            created_at: Date.parse(txn["created_at"]).strftime("Created at %I:%M%p")
          }
        } 
      }.flatten
    end
  
  end

end