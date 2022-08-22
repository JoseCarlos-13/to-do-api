class Tasks::Index::TasksSerializer < ActiveModel::Serializer
  attributes :id, :title, :status
end
