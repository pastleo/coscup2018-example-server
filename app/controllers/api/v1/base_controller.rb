# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::Metal
      include ActionController::MimeResponds
      include Doorkeeper::Rails::Helpers

      ActionController::API.without_modules(
        'Renders:All', :Redirecting
      ).each do |left|
        include left
      end

      before_action :doorkeeper_authorize!

      # TODO: Implement Error Handler
      rescue_from(
        ActiveRecord::RecordNotUnique,
        ActiveRecord::RecordInvalid,
        ActionController::ParameterMissing
      ) do |e|
        render json: {
          error: {
            message: e.message
          }
        }, status: :internal_server_error
      end

      def current_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
