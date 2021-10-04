require "#{Rails.root}/app/block_chain/crypto/base.rb"

class MyNode 

  class << self 
    prepend Crypto::Base

    def address
      base64_public_key
    end

    def signed_message
      sign("message")
    end
  end

end