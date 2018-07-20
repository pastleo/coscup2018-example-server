# frozen_string_literal: true

class DialogSerializer < ActiveModel::Serializer
  attributes :id, :script, :order

  belongs_to :mission
end
