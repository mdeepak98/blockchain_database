class CreateTransaction < ActiveRecord::Migration[6.1]

  def up
    create_table :transactions,  primary_key: "id",null: false, force: true, auto_incrment: true do |t|
      # t.integer :id
      t.string "from_address"
      t.string "to_address"
      t.integer "amount"
      t.integer "status", default: 0
      t.column "created_at", :datetime, default: Time.now
    end
    # execute "ALTER TABLE transactions ADD PRIMARY KEY (id);"
  end

  def down
    drop_table :transactions
  end
end
