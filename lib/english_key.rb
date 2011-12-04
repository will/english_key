require 'securerandom'
require_relative 'english_key/rfc1751'

module EnglishKey
  extend self
  def uuid
    encode(SecureRandom.random_number(2**128 - 1)).tr(' ', '_')
  end

  def encode(num)
    RFC1751.encode num
  end

  def decode(str)
    RFC1751.decode str
  end
end
