require 'rails_helper'

RSpec.describe "Api::V1::Versions", type: :request do
  before :each do
    host! 'api.example.com'
  end

  describe "GET /v1/version" do
    before do
      get api_v1_version_path
    end

    it "have valid response" do
      expect(response).to have_http_status(200)
    end

    it "provide HimeServer::VERSION in repsond" do
      raw = JSON.parse(response.body)
      expect(raw['version']).to eq(HimeServer::VERSION)
    end

    pending "return latest asset bundle build code"
  end
end
