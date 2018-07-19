# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Payment', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:token) { create(:access_token) }

  context 'Google Play' do
    let(:receipt) { file_fixture('payment/google_play/receipt.json').read }
    let(:signature)  { file_fixture('payment/google_play/signature').read }
    let(:public_key) { file_fixture('payment/google_play/public.der').read }

    describe 'POST /v1/google_play/payment' do
      before do
        allow(ENV).to receive(:[])
        allow(ENV).to receive(:[]).with('GOOGLE_PLAY_PUBLIC_KEY').and_return(Base64.encode64(public_key).gsub("\n", ''))

        post api_v1_payments_path(store: :google_play), params: {
          access_token: token.token,
          receipt: receipt,
          signature: signature,
          currency: 'TWD',
          price: '52',
          quantity: 1
        }
      end

      it 'create user success' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
