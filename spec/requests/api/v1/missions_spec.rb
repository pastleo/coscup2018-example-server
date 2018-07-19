# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Missions', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:user) { create(:user) }
  let!(:token) { create(:access_token, resource_owner_id: user.id) }
  let!(:mission) { create(:user_mission, :is_story, user: user) }

  let(:params) { { access_token: token.token } }

  describe 'POST /v1/missions/cancel' do
    before do
      post api_v1_missions_cancel_path, params: params
    end

    it_behaves_like 'valid response'

    it 'returns canceled mission' do
      json = JSON.parse(response.body)
      expect(json).to match_array(
        mission.mission.as_json(only: %i[id name])
      )
    end
  end
end
