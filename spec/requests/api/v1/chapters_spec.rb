# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Chapter', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:token) { create(:access_token) }
  let!(:chapter) { create(:chapter) }

  describe 'GET /v1/chapters' do
    before do
      get api_v1_chapters_path, params: { access_token: token.token }
    end

    it 'have valid response' do
      expect(response).to have_http_status(200)
    end

    it 'returns available chapters' do
      json = JSON.parse(response.body)
      expect(json).to match_array(Chapter.all.as_json(only: %i[id name order]))
    end
  end
end
