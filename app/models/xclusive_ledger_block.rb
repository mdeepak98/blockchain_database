class XclusiveLedgerBlock < ApplicationRecord
  # attribute :transactions, :json
  # attribute :hash, :string
  # attribute :previous_block_hash, :string
  # attribute :nonce, :integer, default: 0
  

  def valid? 
    XclusiveLedgerService::Validator.is_valid_block(self)
  end

  def self.create_new(transactions, prev_block_hash)
    sql = "insert into xclusive_ledger_blocks(transactions,previous_block_hash,nonce) values ('#{transactions.to_json}','#{prev_block_hash}',0)"
    ApplicationRecord.connection.exec_query(sql)
    XclusiveLedgerBlock.find(XclusiveLedgerBlock.count)
  end

  def update_hash_and_nonce(hash,nonce)
    sql = "update xclusive_ledger_blocks set hash='#{hash}', nonce=#{nonce} where id=#{self.id}"
    ApplicationRecord.connection.exec_query(sql)
  end

end