# frozen_string_literal: true

class User < ApplicationRecord
  module Mission
    extend ActiveSupport::Concern

    included do
      def start_mission(mission)
        missions.create(mission: mission)
        mission
      end
    end
  end
end
