class Database
  include ActiveModel::Model

  mattr_accessor :block_chain

  # def initialize
  #   @@block_chain = BlockChain.new
  #   @@block_chain.create_transactions
  # end

  @@block_chain = BlockChain.new

  class << self
    
    def initialize_block_chain
      return if @@block_chain.present?
      create_transactions
    end

    def create_transactions
      puts "======== Adding transaction 1 ============="
      @@block_chain.add_block({caratlane: 1_00_00_000})
      puts "======== Adding transaction 2 ============="
      @@block_chain.add_block({b:10})
      puts "======== Adding transaction 3 ============="
      @@block_chain.add_block({c:10})
    end
  
    def print_transactions 
      JSON.pretty_generate @@block_chain.chain.map(&:instance_values)
    end

    def validate
      unless @@block_chain.valid?
        raise ActiveModel::ValidationError.new(@@block_chain)
      end
    end
  
  end

end