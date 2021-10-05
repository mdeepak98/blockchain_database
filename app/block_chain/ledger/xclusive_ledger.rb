module Ledger

  class XclusiveLedger
    include ActiveModel::Model
  
    mattr_accessor :block_chain
  
    # def initialize
    #   @@block_chain = BlockChain.new
    #   @@block_chain.create_transactions
    # end
  
    @@block_chain = BlockChain.new(Transaction.new(from_address: nil, to_address: 'Caratlane', amount: 1_00_00_000))
  
    class << self
      
      def initialize_block_chain
        return if @@block_chain.present?
        create_transactions
      end
  
      def create_transactions
        puts "======== Adding transaction 1 ============="
        @@block_chain.add_block(Transaction.new(from_address: 'Caratlane', to_address: 'user1', amount: 1_000))
        puts "======== Adding transaction 2 ============="
        @@block_chain.add_block(Transaction.new(from_address: 'user1', to_address: 'user2', amount: 5_00))
        puts "======== Adding transaction 3 ============="
        @@block_chain.add_block(Transaction.new(from_address: 'user2', to_address: 'user3', amount: 250))
      end
    
      def print_transactions 
        JSON.pretty_generate @@block_chain.chain.map(&:instance_values)
      end
  
      def validate
        unless @@block_chain.valid?
          raise ActiveModel::ValidationError.new(@@block_chain)
        end
      end

      def current_state
        @@block_chain.world_state.map{|username, amount| {username: username, xclusive_points: amount}}
      end
    
    end
  
  end

end