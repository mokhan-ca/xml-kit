# frozen_string_literal: true

require 'bundler'
Bundler.setup(:default)
require 'xml/kit'

key_pair = Xml::Kit::KeyPair.generate(use: :encryption)
cipher = Xml::Kit::Crypto::RsaCipher.new(Xml::Kit::Crypto::RsaCipher::ALGORITHM, key_pair.certificate.public_key)
xml = Xml::Kit::EncryptedData.new('<Secret/>', asymmetric_cipher: cipher).to_xml

print Xml::Kit::Decryption.new(private_keys: [key_pair.private_key]).decrypt_xml(xml)
