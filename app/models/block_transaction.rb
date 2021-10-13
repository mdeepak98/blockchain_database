class BlockTransaction
  

  # attr_reader :from_address, :to_address, :amount

  # def initialize(from_address:, to_address:, amount:)
  #   @from_address = from_address
  #   @to_address = to_address
  #   @amount = amount
  #   @timestamp = Time.now.to_i
  # end

  def calculate_hash
    merge_attributes.to_sha256_hash
  end

  def sign_transaction

  end

  def merge_attributes
    from_address.to_s + to_address.to_s + amount.to_s
  end

  def to_formatted_json
    if @from_address.present?
      message = "#{@from_address} sent #{@amount} to #{@to_address}"
    else  
      message = "System added #{@amount} to #{@to_address}"
    end
    # date = Time.at(@created_at).strftime("%B %d, %Y")
    { id: @created_at.to_i, message: message, date: @created_at }
  end

  # private
  # attr_writer :from_address, :to_address, :amount

end