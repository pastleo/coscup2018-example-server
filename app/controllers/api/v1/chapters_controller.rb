# frozen_string_literal: true

module Api
  module V1
    class ChaptersController < Api::V1::BaseController
      def index
        render json: Chapter.all.as_json(only: %i[id name order])
      end
    end
  end
end
