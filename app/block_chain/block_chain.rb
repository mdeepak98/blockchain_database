class BlockChain
  include ActiveModel::Model
  include ActiveModel::Validations
  include BlockChainConstants

  validate :chain_consistency_validation
  attr_reader :chain, :pending_transactions

  def initialize(initial_transactions)
    @chain = [create_genesis_block(initial_transactions)]
  end

  def create_genesis_block(initial_transactions)
    Block.new(timestamp: Time.now.to_i, transactions: [initial_transactions], previous_hash: "0")
  end

  def latest_block 
    @chain.last
  end

  def add_block(transactions)
    new_block = Block.new(timestamp: Time.now.to_i, transactions: [transactions], previous_hash: @chain.last.hash)
    new_block.mine(MINING_DIFFICULTY)
    @chain << new_block
  end

  def chain_consistency_validation
    1.upto(chain.length - 1) do |block_no|
      previous_block, current_block = @chain[block_no - 1], @chain[block_no]

      if current_block.hash != current_block.calculate_hash || current_block.previous_hash != previous_block.calculate_hash
        errors.add(:block, "#{block_no} is invalid")
      end
    end
  end

  def mine_pending_transactions(miner_address)
    # Miners has to pick transactions whose total block size doesn't exceeds 1 MB
    
    add_block(@pending_transactions)
    puts "========== Pending transactions mined =========="
    @pending_transactions = [ Transaction.new(from_address: nil,to_address: miner_address, amount: MINING_REWARD)]
  end

  def create_transaction(transaction)
    @pending_transactions << transaction
  end

  def calculate_balance(address)
    # check if adding new block by taking amount from my block and adding to my block can be an attack. from and to both are my address
    balance = 0
    @chain.each do |block|
      block.transactions.each do |transaction|
        balance += transaction.amount if transaction.to_address == address
        balance -= transaction.amount if transaction.from_address == address
      end
    end
    balance
  end

  def world_state
    state = {}
    @chain.each do |block|
      block.transactions.each do |transaction|
        state[transaction.from_address] = (state[transaction.from_address] || 0) - transaction.amount if transaction.from_address.present?
        state[transaction.to_address] = (state[transaction.to_address] || 0) + transaction.amount 
      end
    end
    state
  end

  def present?
    @chain.present? && @chain.length > 1
  end

  private
  attr_writer :chain, :pending_transactions
end

