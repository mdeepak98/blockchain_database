# module StoredModels

  class Transaction < ApplicationRecord
    # include StoreModel::Model

    # attribute :from_address, :string 
    # attribute :to_address, :string
    # attribute :amount, :integer 
    # attribute :created_at, :datetime, default: Time.now

    enum status: [:pending, :mined]
     
  end

# end