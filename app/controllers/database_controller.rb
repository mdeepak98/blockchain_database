class DatabaseController < ApplicationController

  def index
    Database.initialize_block_chain
    # puts Database.print_transactions
    render json: Database.block_chain
  end


end