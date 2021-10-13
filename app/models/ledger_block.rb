# module StoredModels

  class LedgerBlock
    include StoreModel::Model
    
    attribute :block_hash, :string
    attribute :prev_block_hash, :string
    attribute :nonce, :integer
    attribute :transactions, Transaction.to_array_type
  end

# end