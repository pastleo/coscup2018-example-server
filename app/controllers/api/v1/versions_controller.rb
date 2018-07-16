# frozen_string_literal: true

module Api
  module V1
    class VersionsController < Api::V1::BaseController
      skip_before_action :doorkeeper_authorize!

      def show
        render json: {
          version: HimeServer::VERSION,
          # TODO: Load from admin dashboard to provide assets bundle version
          build: 0
        }
      end
    end
  end
end
