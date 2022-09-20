# frozen_string_literal: true

class Tasks
  class Index
    class TasksSerializer < ActiveModel::Serializer
      attributes :id, :title, :status
    end
  end
end
