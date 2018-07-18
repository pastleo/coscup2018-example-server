# frozen_string_literal: true

module Api
  module V1
    class StoriesController < Api::V1::BaseController
      before_action -> { @chapter = Chapter.find(params[:chapter_id]) }

      def index
        render json: @chapter.stories.as_json(only: %i[id name])
      end

      def start
        # TODO: Implement players's mission to start
      end
    end
  end
end
