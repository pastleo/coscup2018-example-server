# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Stories', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:token) { create(:access_token) }
  let!(:chapter) { create(:chapter) }
  let!(:story) { create(:story, chapter: chapter) }

  let(:params) { { access_token: token.token } }

  describe 'GET /v1/chapters/:id/stories' do
    before do
      get api_v1_chapter_stories_path(chapter), params: params
    end

    it 'have valid response' do
      expect(response).to have_http_status(200)
    end

    it 'returns available chapters' do
      json = JSON.parse(response.body)
      expect(json).to match_array(
        chapter.stories.as_json(only: %i[id name order])
      )
    end
  end
end
