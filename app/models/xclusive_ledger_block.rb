class XclusiveLedgerBlock < ApplicationRecord
  # attribute :transactions, Transaction.to_array_type
  # attribute :hash, :string
  # attribute :previous_block_hash, :string
  # attribute :nonce, :integer, default: 0

  def valid? 
    XclusiveLedgerService::Validator.is_valid_block(self)
  end

end