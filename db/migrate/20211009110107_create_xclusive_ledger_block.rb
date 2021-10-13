class CreateXclusiveLedgerBlock < ActiveRecord::Migration[6.1]
  
  def up
    create_table :xclusive_ledger_blocks do |t|
      t.string "hash"
      t.string "previous_block_hash"
      t.integer "nonce", default: 0
      t.json "transactions"
      t.datetime "created_at", default: Time.now
      # Example: t.column "first_name", :string
    end
  end

  def down 
    drop_table :xclusive_ledger_blocks
  end

end
