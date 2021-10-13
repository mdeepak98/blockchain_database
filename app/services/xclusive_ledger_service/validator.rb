module XclusiveLedgerService

  class Validator
    include Hashing

    def self.validate_chain   
      validate_chain_consistency
    end

    def self.is_valid_block(block)
      calculate_hash(block) == block.hash
    end

    def validate_chain_consistency
      blocks = XclusiveLedgerBlock.all
      blocks[1..-1].each_cons(2) do |prev_block, cur_block|
      # 1.upto(chain.length - 1) do |block_no|
      #   previous_block, current_block = @chain[block_no - 1], @chain[block_no]
  
        if cur_block.hash != cur_block.calculate_hash || cur_block.previous_hash != prev_block.calculate_hash
          raise "#{block_no} is invalid"
        end
      end
    end

  end

end