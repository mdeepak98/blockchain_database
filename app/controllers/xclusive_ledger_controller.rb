class XclusiveLedgerController < ApplicationController

  def index
    # puts Database.print_transactions
    Ledger::XclusiveLedger.initialize_block_chain
    render json: Ledger::XclusiveLedger.current_state
  end

  def world_state

  end


end