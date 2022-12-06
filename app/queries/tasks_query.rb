# frozen_string_literal: true

# task_filter_query
class TasksQuery
  def initialize(params, task = Task)
    @params = params
    @task = task
  end

  def by_status
    @task.where(status: @task.statuses[@params])
  end

  def by_title
    @task.where('title like ?', "%#{@params}%")
  end

  def by_user_name
    @task.joins(:user).where('name like ?', "%#{@params}%")
  end
end
