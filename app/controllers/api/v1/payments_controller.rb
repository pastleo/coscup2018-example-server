# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < Api::V1::BaseController
      def create
        Payment
          .const_get(params[:store].classify)
          .check(current_user, order_params)
        return head 204
      end

      private

      def order_params
        case params[:store]
        when 'google_play' then google_play_params
        when 'itnues' then itnues_params
        end
      end

      def google_play_params
        params.require(:receipt)
        params.require(:signature)
        params.require(:currency)
        params.require(:price)
        params.require(:quantity)
        params.permit(:receipt, :signature, :currency, :price, :quantity)
      end

      def itnues_params
        # TODO
        params
      end
    end
  end
end
