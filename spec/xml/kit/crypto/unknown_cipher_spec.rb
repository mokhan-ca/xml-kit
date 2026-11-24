# frozen_string_literal: true

RSpec.describe ::Xml::Kit::Crypto::UnknownCipher do
  subject { described_class.new("urn:x\n", nil) }

  specify { expect { subject.decrypt('x') }.to raise_error(Xml::Kit::Error, 'Unknown algorithm: "urn:x\n"') }

  describe 'when decrypting with several private keys' do
    let(:key_pair) { Xml::Kit::KeyPair.generate(use: :encryption) }
    let(:cipher) { Xml::Kit::Crypto::RsaCipher.new(Xml::Kit::Crypto::RsaCipher::ALGORITHM, key_pair.public_key) }
    let(:data) { Hash.from_xml(Xml::Kit::EncryptedData.new('<Secret/>', asymmetric_cipher: cipher).to_xml) }
    let(:decryption) { Xml::Kit::Decryption.new(private_keys: [OpenSSL::PKey::RSA.new(2048), key_pair.private_key]) }

    [%w[EncryptedData EncryptionMethod], %w[EncryptedData KeyInfo EncryptedKey EncryptionMethod]].each do |path|
      it "raises for the algorithm of #{path.join('/')}" do
        data.dig(*path)['Algorithm'] = 'urn:x'
        expect { decryption.decrypt_hash(data) }.to raise_error(Xml::Kit::Error, 'Unknown algorithm: "urn:x"')
      end
    end
  end
end
