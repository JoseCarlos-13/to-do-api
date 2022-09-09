# frozen_string_literal: true

#app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  def index
    tasks = Task.all

    render json: tasks,
           each_serializer: Tasks::Index::TasksSerializer,
           status: :ok
  end
end
