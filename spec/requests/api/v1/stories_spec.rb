# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Stories', type: :request do
  before :each do
    host! 'api.example.com'
  end

  let!(:token) { create(:access_token) }
  let!(:chapter) { create(:chapter) }
  let!(:story) { create(:story, chapter: chapter) }
  let!(:dialogs) { create_list(:dialog, 2, mission: story) }

  let(:params) { { access_token: token.token } }

  describe 'GET /v1/chapters/:id/stories' do
    before do
      get api_v1_chapter_stories_path(chapter), params: params
    end

    it_behaves_like 'valid response'

    it 'returns available chapters' do
      json = JSON.parse(response.body)
      expect(json).to match_array(
        chapter.stories.as_json(only: %i[id name order])
      )
    end
  end

  describe 'POST /v1/chapters/:id/stories/:id/start' do
    before do
      post start_api_v1_chapter_story_path(chapter, story), params: params
    end

    it_behaves_like 'valid response'

    it 'returns current started story' do
      json = JSON.parse(response.body)
      expect(json).to match(
        story.dialogs.first.as_json(only: %i[script])
      )
    end
  end
end
