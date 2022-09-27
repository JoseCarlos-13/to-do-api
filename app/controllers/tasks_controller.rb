# frozen_string_literal: true

# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    pagy, tasks = pagy(Task.all, page: params[:page], items: params[:items]) #rubocop:disable Lint/UselessAssignment

    render json: tasks,
           each_serializer: Tasks::Index::TasksSerializer,
           status: :ok
  end
end
