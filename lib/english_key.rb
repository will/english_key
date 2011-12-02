require 'securerandom'
require_relative 'english_key/rfc1751'

module EnglishKey
  def self.uuid
    SecureRandom.uuid
  end
end
