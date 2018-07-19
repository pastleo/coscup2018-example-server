# frozen_string_literal: true

module Api
  module V1
    class MissionsController < Api::V1::BaseController
      def next
        render json: current_user
          .current_mission
          .next
          .as_json(only: %i[script])
      end

      def cancel
        # TODO: Raise error when no incomplete mission found
        render json: current_user
          .current_mission
          &.cancel
          &.as_json(only: %i[id name])
      end
    end
  end
end
