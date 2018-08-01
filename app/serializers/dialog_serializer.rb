# frozen_string_literal: true

class DialogSerializer < ActiveModel::Serializer
  attributes :id, :script, :order, :character_id, :character_expression

  belongs_to :mission
end
