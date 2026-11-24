# frozen_string_literal: true

module Xml
  module Kit
    # {include:file:spec/xml/kit/decryption_spec.rb}
    class Decryption
      ELEMENTS = %w[
        xenc:EncryptionMethod
        ds:KeyInfo[not(parent::xenc:EncryptedKey)]
        xenc:EncryptedKey
        xenc:CipherData
        xenc:CipherValue
      ].join('|').freeze
      NAMESPACES = { 'ds' => Namespaces::XMLDSIG, 'xenc' => Namespaces::XMLENC }.freeze
      private_constant :ELEMENTS, :NAMESPACES

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
        decrypt_element(Nokogiri::XML(raw_xml, &:strict).root)
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

        node.parent.replace(decrypt_element(node))[0]
      end

      private

      def decrypt_element(element)
        decrypt_hash(element.name => hash_from(element))
      end

      def hash_from(element)
        return element.text if element.name == 'CipherValue'

        children = element.xpath(ELEMENTS, NAMESPACES)
        raise Error, "#{element.name} contains repeated elements" if children.uniq(&:name).size < children.size

        hash = children.to_h { |child| [child.name, hash_from(child)] }
        hash.merge('Algorithm' => element['Algorithm']).compact.presence
      end

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
