class String 

  def to_sha256_hash
    Digest::SHA256.hexdigest(self)
  end

  def to_rsa_obj
    OpenSSL::PKey::RSA.new(self.decode_base64)
  end

  def to_base64
    Base64.encode64(self)
  end

  def decode_base64
    Base64.decode64(self)
  end
end