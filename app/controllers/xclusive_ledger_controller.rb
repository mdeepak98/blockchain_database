class XclusiveLedgerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # puts Database.print_transactions
    Ledger::XclusiveLedger.initialize_block_chain
    render json: Ledger::XclusiveLedger.current_state
  end

  def add_transaction
    transaction = Transaction.new(from_address: "Caratlane", to_address: params["to"], amount: params["amount"].to_i)
    Ledger::XclusiveLedger.block_chain.add_pending_transaction(transaction)
    render json: { message: "Transaction added successfully."}
  end

  def mine
    Ledger::XclusiveLedger.block_chain.mine_pending_transactions
    render json: Ledger::XclusiveLedger.current_state
  end

  def transaction_history
    render json: Ledger::XclusiveLedger.block_chain.history
  end

  def block_chain
    render json: Ledger::XclusiveLedger.block_chain.as_json
  end


end