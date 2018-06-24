# frozen_string_literal: true

require 'openssl'
require 'base64'

module IAP
  class GooglePlay
    class << self
      def verify(signature, receipt)
        self.new(Config.google_play.public_key)
            .verify(signature, receipt)
      end
    end

    attr_reader :key

    def initialize(base64_encoded_key)
      @key = OpenSSL::PKey::RSA.new(
        Base64.decode64(base64_encoded_key)
      )
    end

    def verify(signature, receipt)
      key.verify(
        OpenSSL::Digest::SHA1.new,
        Base64.decode64(signature),
        receipt
      )
    end
  end
end
