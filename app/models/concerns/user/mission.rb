# frozen_string_literal: true

class User < ApplicationRecord
  module Mission
    extend ActiveSupport::Concern

    included do
      def start_mission(mission)
        # TODO: Block user start missing if have incomplete mission
        transaction do
          dialog = mission.dialogs.first
          missions.create(mission: mission, progress: dialog.order)
          dialog
        end
      end

      def current_mission
        missions.incomplete.first
      end
    end
  end
end
