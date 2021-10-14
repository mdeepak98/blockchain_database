Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'database#index'

  # get 'app', to: 'table#index'
  get '/xclusive_ledger', to: 'xclusive_ledger#index'
  get '/xclusive_ledger/mine', to: 'xclusive_ledger#mine'
  get '/xclusive_ledger/mine_blocks', to: 'xclusive_ledger#mine_blocks'
  get '/xclusive_ledger/transaction_history', to: 'xclusive_ledger#transaction_history'
  post '/xclusive_ledger/add_transaction', to: 'xclusive_ledger#add_transaction'
  get '/xclusive_ledger/block_chain', to: 'xclusive_ledger#block_chain'

  root 'table#index'
end
