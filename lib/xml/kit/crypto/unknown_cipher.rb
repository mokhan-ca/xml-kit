# frozen_string_literal: true

module Xml
  module Kit
    module Crypto
      class UnknownCipher
        attr_reader :algorithm, :key

        def self.matches?(_algorithm)
          true
        end

        def initialize(algorithm, key)
          @algorithm = algorithm
          @key = key
        end

        def decrypt(_cipher_text)
          raise ::Xml::Kit::Error, "Unknown algorithm: #{algorithm.inspect}"
        end
      end
    end
  end
end
