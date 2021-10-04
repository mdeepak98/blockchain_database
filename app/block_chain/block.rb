class Block
  include ActiveModel::Model

  attr_reader :index, :timestamp, :transactions, :previous_hash, :hash, :nonce

  def initialize(timestamp:, transactions:, previous_hash: )
    @transactions = transactions
    @timestamp = timestamp
    @previous_hash = previous_hash
    @hash = calculate_hash()
    @nonce = 0
    # @hash = calculate_hash() + 'a' # to simulate hacked block
  end

  def calculate_hash 
    merge_block_values.to_sha256_hash
  end

  def merge_block_values
    @timestamp.to_s + @transactions.to_s + @previous_hash.to_s + @nonce.to_s
  end

  def mine(difficulty)
    while @hash[0..difficulty-1] != "0"*difficulty
      @nonce += 1
      @hash = calculate_hash()
    end
  end

  private
  attr_writer :timestamp, :transactions, :previous_hash, :hash, :nonce

end