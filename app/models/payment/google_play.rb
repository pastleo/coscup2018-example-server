# frozen_string_literal: true

class Payment
  class GooglePlay < Payment
    class << self
      def check(user, order_params)
        receipt = JSON.parse(order_params[:receipt])
        order = find_or_create_by!(transaction_id: receipt['orderId']) do |o|
          setup(user, o, receipt, order_params)
        end

        return if already_checked?(order)
        order.verify_receipt!(order_params[:signature])
      end

      def setup(user, order, receipt, params)
        order.product_id = receipt['productId']
        order.receipt = params[:receipt]
        order.purchased_at = timestamp_to_datetime(receipt['purchaseTime'])
        order.user = user
        order.currency = params[:currency]
        order.price = params[:price]
        order.quantity = params[:quantity]
      end

      def timestamp_to_datetime(time)
        Time.zone.at(time.to_i / 1000).to_datetime
      end

      def already_checked?(order)
        return unless order.checked?
        return true if order.verified?
        raise ReceiptInvalid
      end
    end

    default_scope -> { where(store: :google_play) }

    def verify_receipt!(signature)
      transaction do
        raise ReceiptInvalid unless valid_receipt?(signature)
        save_valid_receipt!
      end
    rescue ReceiptInvalid
      save_invalid_receipt!
      raise
    end

    private

    def valid_receipt?(signature)
      receipt_data = JSON.parse(receipt)
      return false unless receipt_data['orderId'] == transaction_id

      receipt_without_linebreaks = receipt.gsub(/(\r\n|\r|\n)/, '')
      IAP::GooglePlay.verify(signature, receipt_without_linebreaks)
    end

    def save_valid_receipt!
      self.checked = true
      self.verified = true
      save!
    end

    def save_invalid_receipt!
      self.checked = true
      self.verified = false
      save!
    end
  end
end
