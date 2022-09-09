# frozen_string_literal: true
class Tasks::Index::TasksSerializer < ActiveModel::Serializer

  attributes :id, :title, :status
end
