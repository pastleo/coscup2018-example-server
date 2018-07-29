# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Gachas', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:token) { create(:access_token) }
  let!(:gacha) { create(:gacha) }

  describe 'GET /v1/gachas' do
    before do
      get api_v1_gachas_path, params: { access_token: token.token }
    end

    it 'have valid response' do
      expect(response).to have_http_status(200)
    end

    it 'returns opened gachas' do
      json = JSON.parse(response.body)
      hash = JSON.parse(serialized_json(Gacha.opened))
      expect(json).to match_array(hash)
    end
  end

  describe 'POST /v1/gachas/:id/draw' do
    let!(:gacha) { create(:gacha, :opened) }
    let!(:character) { create(:character) }
    let!(:group) { create(:gacha_group, gacha: gacha) }
    let!(:item) { create(:gacha_item, group: group, rewardable: character) }

    before do
      post api_v1_gacha_draw_path(gacha), params: { access_token: token.token }
    end

    it 'have valid response' do
      expect(response).to have_http_status(200)
    end

    it 'returns reward item as result' do
      json = JSON.parse(response.body)
      hash = JSON.parse(serialized_json(item))
      expect(json).to match_array(hash)
    end
  end
end
