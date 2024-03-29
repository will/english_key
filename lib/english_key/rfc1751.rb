require_relative 'rfc1751_words'
module EnglishKey
  module RFC1751
    extend self

    ChecksumError = Class.new(ArgumentError)

    def encode(num)
      split_64bit(num).map {|part| encode_64bit part }.join ' '
    end

    def decode(words)
      base_array_to_int( decode_phrases(words).flatten, 2**64)
    end

    private

    def split_64bit(num)
      parts = []
      while num > 0
        parts.unshift num % 2**64
        num /= 2**64
      end
      parts
    end

    def encode_64bit(num)
      bits = 63.downto(0).map{|i| num[i] }

      keys = bits.each_slice(11).map {|bit_array| base_array_to_int(bit_array, 2) }

      keys[5] = (keys[5] << 2) + checksum(num)

      keys.map {|idx| WORDS[idx] }
    end

    def checksum(num)
      (0..63).step(2).inject(0) { |sum,j| sum + 2*num[j+1] + num[j] } & 3
    end

    def decode_phrases(words)
      words.split(/ /).each_slice(6).map { |phrase| decode_phrase phrase }
    end

    def decode_phrase(phrase)
      nums = phrase.map{|word| WORDS.index word}
      decoded = nums.inject(0) { |sum, n| (sum << 11) + n } >> 2
      raise ChecksumError unless (nums.last & 3) == checksum(decoded)
      decoded
    end

    def base_array_to_int(arry, base)
      arry.reverse.each.with_index.inject(0) {|sum, (n,pwr)| sum + n * base**pwr }
    end
  end
end
