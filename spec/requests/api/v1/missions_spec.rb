# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Missions', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:user) { create(:user) }
  let!(:token) { create(:access_token, resource_owner_id: user.id) }
  let!(:mission) { create(:user_mission, :is_story, user: user, progress: 1) }

  let(:params) { { access_token: token.token } }

  describe 'POST /v1/missions/next' do
    context 'in progress' do
      let!(:mission) { create(:user_mission, :is_story, user: user) }
      let!(:dialogs) { create_list(:dialog, 2, mission: mission.mission) }

      before do
        mission.update(progress: dialogs.first.order)
        post api_v1_missions_next_path, params: params
      end

      it_behaves_like 'valid response'

      it 'returns next dialog' do
        json = JSON.parse(response.body)
        hash = JSON.parse(serialized_json(dialogs.last))
        expect(json).to match_array(hash)
      end
    end

    # TODO: Add database rewind to reset result
    context 'completed' do
      let!(:mission) { create(:user_mission, :is_story, user: user) }
      let!(:dialogs) { create_list(:dialog, 2, mission: mission.mission) }

      before do
        mission.update(progress: dialogs.last.order)
        post api_v1_missions_next_path, params: params
      end

      it_behaves_like 'valid response'

      it 'returns current mission' do
        json = JSON.parse(response.body)
        hash = JSON.parse(serialized_json(mission.reload))
        expect(json).to match(hash)
      end

      it 'should be completed' do
        json = JSON.parse(response.body)
        expect(json['completed']).to be_truthy
      end
    end
  end

  describe 'POST /v1/missions/cancel' do
    let!(:mission) { create(:user_mission, :is_story, user: user, progress: 0) }

    before do
      post api_v1_missions_cancel_path, params: params
    end

    it_behaves_like 'valid response'

    it 'returns canceled mission' do
      json = JSON.parse(response.body)
      hash = JSON.parse(serialized_json(mission.reload))
      expect(json).to match(hash)
    end

    it 'should have canceled_at time' do
      json = JSON.parse(response.body)
      expect(json['canceled_at']).not_to be_nil
    end
  end
end
