# frozen_string_literal: true

class Foo
  class Bar
    class Tasks::Index::TasksSerializer < ActiveModel::Serializer
      attributes :id, :title, :status
    end
  end
end
