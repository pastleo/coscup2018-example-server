# frozen_string_literal: true

class ChapterSerializer < ActiveModel::Serializer
  attributes :id, :name, :order
end
