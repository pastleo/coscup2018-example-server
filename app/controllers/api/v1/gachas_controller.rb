# frozen_string_literal: true

module Api
  module V1
    class GachasController < Api::V1::BaseController
      def index
        @gachas = Gacha.opened
        render json: @gachas
      end

      def draw
        gacha = Gacha.opened.find(params[:gacha_id])
        result = gacha.draw
        result.reward_to(current_user)
        render json: result
      end
    end
  end
end
