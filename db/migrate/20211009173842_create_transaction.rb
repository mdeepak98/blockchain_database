class CreateTransaction < ActiveRecord::Migration[6.1]

  def up
    create_table :transactions do |t|
      t.string "from_address"
      t.string "to_address"
      t.integer "amount"
      t.integer "status", default: 0
      t.column "created_at", :datetime, default: Time.now
    end
  end

  def down
    drop_table :transactions
  end
end
