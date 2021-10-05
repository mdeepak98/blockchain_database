class XclusiveLedgerController < ApplicationController

  def index
    # puts Database.print_transactions
    Ledger::XclusiveLedger.initialize_block_chain
    render json: Ledger::XclusiveLedger.block_chain
  end

  def world_state

  end


end