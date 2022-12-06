# frozen_string_literal: true

# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index # rubocop:disable Metrics/BlockLength
    if params[:status].present? || params[:title].present? || params[:user_name].present?
      task_list = TasksQuery.new(params[:status]).by_status if params[:status].present?
      task_list = TasksQuery.new(params[:title]).by_title if params[:title].present?
      task_list = TasksQuery.new(params[:user_name]).by_user_name if params[:user_name].present?
      task_list = task_list.includes(:user)
    else
      task_list = Task.includes(:user)
    end

    @pagy, tasks = pagy(
      task_list,
      page: params[:page], items: params[:items]
    )

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
