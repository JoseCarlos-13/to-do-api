# frozen_string_literal: true

# task_filter_query
class TaskFilterQuery
  def initialize(params)
    @params = params
  end

  def filter_by_status
    Task.where(status: Task.statuses[@params])
  end

  def filter_by_title
    Task.where('title like ?', "%#{@params}%")
  end

  def filter_by_user_name
    Task.joins(:user).where('name like ?', "%#{@params}%")
  end
end
