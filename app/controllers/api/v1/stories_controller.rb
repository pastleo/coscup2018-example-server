# frozen_string_literal: true

module Api
  module V1
    class StoriesController < Api::V1::BaseController
      before_action -> { @chapter = Chapter.find(params[:chapter_id]) }
      before_action :find_story, only: :start

      def index
        render json: @chapter.stories.as_json(only: %i[id name order])
      end

      def start
        # TODO: Add ActiveModel::Serializer
        render json: current_user
          .start_mission(@story)
          .as_json(only: %i[script])
      end

      private

      def find_story
        @story = @chapter.stories.find(params[:id])
      end
    end
  end
end
