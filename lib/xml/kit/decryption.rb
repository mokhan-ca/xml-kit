# frozen_string_literal: true

module Xml
  module Kit
    # {include:file:spec/xml/kit/decryption_spec.rb}
    class Decryption
      # The list of private keys to use to attempt to decrypt the document.
      attr_reader :cipher_registry, :private_keys

      def initialize(private_keys:, cipher_registry: ::Xml::Kit::Crypto)
        @private_keys = private_keys
        @cipher_registry = cipher_registry
      end

      # Decrypts an EncryptedData section of an XML document.
      #
      # @param data [Hash] the XML document converted to a [Hash] using Hash.from_xml.
      # @deprecated Use {#decrypt_hash} instead of this
      def decrypt(data)
        ::Xml::Kit.deprecate(
          'decrypt is deprecated. Use decrypt_xml or decrypt_hash instead.'
        )
        decrypt_hash(data)
      end

      # Decrypts an EncryptedData section of an XML document.
      #
      # @param raw_xml [String] the XML document as a string.
      def decrypt_xml(raw_xml)
        decrypt_hash(Hash.from_xml(raw_xml))
      end

      # Decrypts an EncryptedData section of an XML document.
      #
      # @param hash [Hash] the XML document converted to a [Hash] using Hash.from_xml.
      def decrypt_hash(hash)
        data = hash['EncryptedData']
        with_each_private_key do |private_key|
          to_plaintext(data, to_plaintext(data['KeyInfo']['EncryptedKey'], private_key))
        end
      end

      # Decrypts an EncryptedData Nokogiri::XML::Element.
      #
      # @param node [Nokogiri::XML::Element.] the XML node to decrypt.
      def decrypt_node(node)
        return node unless !node.nil? && node.name == 'EncryptedData'

        node.parent.replace(decrypt_xml(node.to_s))[0]
      end

      private

      def with_each_private_key(attempts = private_keys.count)
        private_keys.each do |private_key|
          attempts -= 1
          return yield(private_key)
        rescue OpenSSL::OpenSSLError, ArgumentError
          raise if attempts.zero?
        end
        raise DecryptionError, private_keys
      end

      def to_plaintext(element, key)
        cipher_registry
          .cipher_for(element['EncryptionMethod']['Algorithm'], key)
          .decrypt(Base64.decode64(element['CipherData']['CipherValue']))
      end
    end
  end
end
