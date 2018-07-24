# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Payment', type: :request do
  before :each do
    host! 'api.example.com'

    allow(ENV).to receive(:[])
  end

  let!(:user) { create(:user) }
  let!(:token) { create(:access_token, resource_owner_id: user.id) }

  context 'Google Play' do
    before do
      allow(ENV).to receive(:[])
        .with('GOOGLE_PLAY_PUBLIC_KEY')
        .and_return(Base64.encode64(public_key).delete("\n"))
    end

    let(:receipt) { file_fixture('payment/google_play/receipt.json').read }
    let(:signature)  { file_fixture('payment/google_play/signature').read }
    let(:public_key) { file_fixture('payment/google_play/public.der').read }

    let(:params) do
      {
        access_token: token.token,
        receipt: receipt,
        signature: signature,
        currency: 'TWD',
        price: '52',
        quantity: 50
      }
    end

    describe 'POST /v1/google_play/payment' do
      it 'create payment success' do
        post api_v1_payments_path(store: :google_play), params: params
        expect(response).to have_http_status(204)
      end

      it "should increment user's stone" do
        expect do
          post api_v1_payments_path(store: :google_play), params: params
        end.to change { user.reload.stone }.by(50)
      end
    end
  end
end
