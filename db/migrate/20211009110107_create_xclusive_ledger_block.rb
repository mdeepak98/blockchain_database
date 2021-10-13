class CreateXclusiveLedgerBlock < ActiveRecord::Migration[6.1]
  
  def up
    create_table :xclusive_ledger_blocks,  primary_key: "id",null: false, force: true, auto_incrment: true do |t|
      # t.integer :id
      t.string "hash"
      t.string "previous_block_hash"
      t.integer "nonce"
      t.json "transactions"
      t.column "created_at", :datetime, default: Time.now
      # Example: t.column "first_name", :string
    end
    # execute "ALTER TABLE xclusive_ledger_blocks ADD PRIMARY KEY (id);"
  end

  def down 
    drop_table :xclusive_ledger_blocks
  end

end
