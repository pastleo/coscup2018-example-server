require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /api/v1/users" do
    before do
      post api_v1_users_path, params: {
        username: Faker::Internet.user_name,
        password: Faker::Internet.password
      }
    end

    it "create user success" do
      expect(response).to have_http_status(200)
    end

    it "receive the access_token" do
      raw = JSON.parse(response.body)
      p raw
      expect(raw['access_token']).not_to be_nil
    end
  end
end
