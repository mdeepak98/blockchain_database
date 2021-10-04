module Crypto 

  module Base 

    def sign(message)
      RSA_OBJ.sign(DIGEST_FUNCTION, message)
    end
  
    def base64_public_key
      RSA_OBJ.public_key.to_pem.to_base64
    end
  
    def decrypt_message(encrypted_message)
      RSA_OBJ.private_decrypt(encrypted_message)
    end
  
    def verify_signature(sender_public_key, signature, message)
      sender_public_key.to_rsa_obj.verify(func, signature, decrypted)
    end
  
    private
      KEY_LENGTH = 4096
      RSA_OBJ = OpenSSL::PKey::RSA.new(KEY_LENGTH)
      DIGEST_FUNCTION = OpenSSL::Digest::SHA256.new
      
  end
end