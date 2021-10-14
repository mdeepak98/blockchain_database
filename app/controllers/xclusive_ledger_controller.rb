class XclusiveLedgerController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    # puts Database.print_transactions
    # Ledger::XclusiveLedger.initialize_block_chain
    # render json: Ledger::XclusiveLedger.current_state
    render json: XclusiveLedgerService::Ledger.current_state
  end

  def add_transaction
    # transaction = Transaction.new(from_address: "Caratlane", to_address: params["to"], amount: params["amount"].to_i)
    # Ledger::XclusiveLedger.block_chain.add_pending_transaction(transaction)
    Transaction.create(from_address: "Caratlane", to_address: params["to"], amount: params["amount"].to_i)
    render json: { message: "Transaction added successfully."}
  end

  def mine_blocks
    # Ledger::XclusiveLedger.block_chain.mine_pending_transactions
    XclusiveLedgerService::Miner.mine_pending_transactions()
    render json: XclusiveLedgerService::Ledger.current_state
  end

  def transaction_history
    # render json: Ledger::XclusiveLedger.block_chain.history
    render json: XclusiveLedgerService::Ledger.history
  end

  def block_chain
    # render json: Ledger::XclusiveLedger.block_chain.as_json
    render json: { chain: XclusiveLedgerBlock.all.as_json }
  end


end