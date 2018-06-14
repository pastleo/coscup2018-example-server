# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :doorkeeper_authorize!

      def create
        # TODO: Handling exists user
        # TODO: Recording DeviceID
        user = User.create!(register_params)
        token = Doorkeeper::AccessToken.create(resource_owner_id: user.id)

        render json: {
          username: user.username,
          token: token.token
        }
      end

      private

      def register_params
        params.require(:username)
        params.require(:password)
        params.permit(:username, :password, :device_id)
      end
    end
  end
end
