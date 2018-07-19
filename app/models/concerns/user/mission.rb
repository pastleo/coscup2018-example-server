# frozen_string_literal: true

class User < ApplicationRecord
  module Mission
    extend ActiveSupport::Concern

    included do
      def start_mission(mission)
        # TODO: Block user start missing if have incomplete mission
        missions.create(mission: mission)
        mission.dialogs.first
      end
    end
  end
end
