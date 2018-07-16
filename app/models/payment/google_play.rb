# frozen_string_literal: true

class Payment
  class GooglePlay < Payment
    class << self
      def check(user, order_params)
        receipt = JSON.parse(order_params[:receipt])
        order = find_or_create_by!(transaction_id: receipt['orderId']) do |o|
          o.product_id = receipt['productId']
          o.receipt = order_params[:receipt]
          o.purchased_at = Time.at(receipt['purchaseTime'].to_i / 1000).to_datetime
          o.user = user
          o.currency = order_params[:currency]
          o.price = order_params[:price]
          o.quantity = order_params[:quantity]
        end

        return if already_checked?(order)
        order.verify_receipt!(order_params[:signature])
      end

      def already_checked?(order)
        if order.checked?
          if order.verified?
            return true
          else
            raise ReceiptInvalid
          end
        else
          false
        end
      end
    end

    default_scope -> { where(store: :google_play) }

    def verify_receipt!(signature)
      transaction do
        if valid_receipt?(signature)
          save_valid_receipt!
        else
          raise ReceiptInvalid
        end
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
