# frozen_string_literal: true

require 'net/http'

module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :doorkeeper_authorize!
      before_action :cors_preflight_check
      after_action :cors_set_access_control_headers

      def create
        # TODO: Handling exists user
        # TODO: Recording DeviceID
        user = User.new(register_params)
        user.username = user.email
        user.validate!
        #user.firebase_uid = register_on_firebase()
        user.save!
        user.firebase_uid = user.id
        user.save!
        token = Doorkeeper::AccessToken.create(resource_owner_id: user.id)

        render json: {
          email: user.email,
          access_token: token.token
        }
      end

      def session
        user = User.find_for_database_authentication(:email => params[:email])
        if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
          token = Doorkeeper::AccessToken.create(resource_owner_id: user.id)

          render json: {
            email: user.email,
            access_token: token.token
          }
        else
          render json: { error: 'invalid email and password' }
        end
      end

      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
        headers['Access-Control-Max-Age'] = "1728000"
      end

      def cors_preflight_check
        if request.method == 'OPTIONS'
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, X-Requested-With, X-Prototype-Version, Token'
          headers['Access-Control-Max-Age'] = '1728000'

          render :text => '', :content_type => 'text/plain'
        end
      end

      private

      def register_params
        params.require(:email)
        params.require(:password)
        params.permit(:email, :password, :device_id)
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
