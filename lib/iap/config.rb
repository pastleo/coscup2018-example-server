# frozen_string_literal: true

module IAP
  class Config < Settingslogic
    source Rails.root.join('config', 'iap.yml')
    namespace Rails.env
  end
end
