# frozen_string_literal: true

# task_filter_query
class TasksQuery
  def initialize(params, task = Task.all)
    @params = params
    @task = task
  end

  def call
    query_list = @task
    query_list = by_status(query_list) if @params[:status].present?
    query_list = by_title(query_list) if @params[:title].present?
    query_list = by_user_name(query_list) if @params[:user_name].present?

    query_list
  end

  def by_status(query_list)
    query_list.where(status: @task.statuses[@params[:status]])
  end

  def by_title(query_list)
    query_list.where('title like ?', "%#{@params[:title]}%")
  end

  def by_user_name(query_list)
    query_list.joins(:user).where('name like ?', "%#{@params[:user_name]}%")
  end
end
