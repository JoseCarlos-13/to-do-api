# frozen_string_literal: true

module Tasks
  module Show
    class TasksSerializer < ActiveModel::Serializer
      attributes :id, :title, :status, :description
    end
  end
end
