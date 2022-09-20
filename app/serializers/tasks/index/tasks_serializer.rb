# frozen_string_literal: true

module A
  class Tasks::Index::TasksSerializer < ActiveModel::Serializer
    attributes :id, :title, :status
  end
end
