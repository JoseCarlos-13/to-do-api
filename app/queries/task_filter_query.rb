class TaskFilterQuery
  def initialize(task_list, params)
    @task_list = task_list
    @params = params
  end

  def filter_by_status
    @task_list.where(status: Task.statuses[@params])
  end

  def filter_by_title
    @task_list.where('title like ?', "%#{@params}%")
  end

  def filter_by_user_name
    @task_list.joins(:user).where("name like ?", "%#{@params}%")
  end
end