# frozen_string_literal: true

# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, tasks = pagy(Task.all, page: params[:page], items: params[:items])

    render json: tasks,
           each_serializer: Tasks::Index::TasksSerializer, status: :ok
  end

  def create
    task = Task.new(task_params)

    if task.save
      render json: task,
             serializer: Tasks::Create::TasksSerializer, status: :created
    else
      render json: { errors: task.errors }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:status, :description, :title, :user_id)
  end
end
