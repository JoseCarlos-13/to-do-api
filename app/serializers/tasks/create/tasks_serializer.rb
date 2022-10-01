# frozen_string_literal: true

module Tasks
  module Create
    class TasksSerializer < ActiveModel::Serializer
      attributes :id, :title, :status, :description
    end
  end
end
