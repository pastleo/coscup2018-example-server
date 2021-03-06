# frozen_string_literal: true

module Api
  module V1
    class StoriesController < Api::V1::BaseController
      before_action -> { @chapter = Chapter.find(params[:chapter_id]) }
      before_action :find_story, only: :start

      def index
        render json: @chapter.stories
      end

      def start
        render json: current_user
          .start_mission(@story)
      end

      private

      def find_story
        @story = @chapter.stories.find(params[:id])
      end
    end
  end
end
