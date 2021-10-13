module XclusiveLedgerService
  
  module Hashing
    include XclusiveLedgerConstants

    def calculate_hash(block) 
      merge_block_values(block).to_sha256_hash
    end
  
    def merge_block_values(block)
      block.transactions.to_s + block.previous_block_hash.to_s + block.nonce.to_s
    end
  
    def valid_hash?(hash)
      difficulty = MINING_DIFFICULTY
      # puts difficulty, hash
      hash.present? && hash[0..difficulty-1] == "0"*difficulty
    end

  end

end