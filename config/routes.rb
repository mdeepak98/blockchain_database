Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'database#index'

  # get 'app', to: 'table#index'
  root 'xclusive_ledger#index'
end
