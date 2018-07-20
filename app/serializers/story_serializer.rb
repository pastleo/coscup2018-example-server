# frozen_string_literal: true

class StorySerializer < ActiveModel::Serializer
  attributes :id, :name, :order
end
