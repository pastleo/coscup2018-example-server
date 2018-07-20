# frozen_string_literal: true

class UserMissionSerializer < ActiveModel::Serializer
  attributes :id, :progress, :completed, :canceled_at

  belongs_to :mission
end
