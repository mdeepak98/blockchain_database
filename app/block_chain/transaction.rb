class Transaction 
  include ActiveModel::Model

  attr_reader :from_address, :to_address, :amount

  def initialize(from_address:, to_address:, amount:)
    @from_address = from_address
    @to_address = to_address
    @amount = amount
  end

  def calculate_hash
    merge_attributes.to_sha256_hash
  end

  def sign_transaction

  end

  def merge_attributes
    from_address.to_s + to_address.to_s + amount.to_s
  end

  private
  attr_writer :from_address, :to_address, :amount
end