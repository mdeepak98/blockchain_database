# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_09_173842) do

  create_table "transactions", force: :cascade do |t|
    t.string "from_address"
    t.string "to_address"
    t.integer "amount"
    t.integer "status", default: 0
    t.datetime "created_at", default: "2021-10-13 09:30:23"
  end

  create_table "xclusive_ledger_blocks", force: :cascade do |t|
    t.string "hash"
    t.string "previous_block_hash"
    t.integer "nonce"
    t.json "transactions"
    t.datetime "created_at", default: "2021-10-13 09:30:23"
  end

end
