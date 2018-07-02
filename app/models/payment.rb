# frozen_string_literal: true

class Payment < ApplicationRecord
  class ReceiptInvalid < StandardError; end

  belongs_to :user

  enum store: {
    google_play: 0,
    itunes: 1
  }

  # TODO: Reward user stone after checked payment
end
