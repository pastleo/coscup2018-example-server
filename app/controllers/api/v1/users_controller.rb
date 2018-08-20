# frozen_string_literal: true

require 'net/http'

module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :doorkeeper_authorize!

      def create
        # TODO: Handling exists user
        # TODO: Recording DeviceID
        user = User.new(register_params)
        user.validate!
        user.firebase_uid = register_on_firebase()
        #user.firebase_uid = user.id
        user.save!
        token = Doorkeeper::AccessToken.create(resource_owner_id: user.id)

        render json: {
          username: user.username,
          access_token: token.token
        }
      end

      def session
        user = User.find_for_database_authentication(:username => params[:username])
        if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
          token = Doorkeeper::AccessToken.create(resource_owner_id: user.id)

          render json: {
            username: user.username,
            access_token: token.token
          }
        else
          render json: { error: 'invalid username and password' }
        end
      end

      private

      def register_params
        params.require(:email)
        params.require(:username)
        params.require(:password)
        params.permit(:email, :username, :password, :device_id)
      end

      API_KEY = JSON.parse!(File.read(Rails.root.join('config/firebase.json')))['api_key']
      def register_on_firebase
        uri = URI.parse("https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=#{API_KEY}")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request.body = JSON.dump({
          "email" => register_params[:email],
          "password" => register_params[:password],
          "returnSecureToken" => true
        })

        req_options = {
          use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end

        JSON.parse(response.body)['localId']
      end
    end
  end
end
