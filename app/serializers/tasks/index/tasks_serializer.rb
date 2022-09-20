# frozen_string_literal: true

module Tasks
  module Index
    class TasksSerializer < ActiveModel::Serializer
      attributes :id, :title, :status
    end
  end
end
