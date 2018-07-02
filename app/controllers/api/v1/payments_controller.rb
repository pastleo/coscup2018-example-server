# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < Api::V1::BaseController
      def create
        store.check(current_user, order_params)
        head 204
      end

      private

      def store
        case params[:store]
        when 'google_play' then Payment::GooglePlay
        when 'itunes' then Payment::Itunes
        else Payment
        end
      end

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
