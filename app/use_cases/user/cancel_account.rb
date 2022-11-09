 class User::CancelAccount
  def initialize(user)
    @user = user
  end

  def call
    if @user.tasks.where(status: 'in_development').count == 0
      update_user_status_if_not_have_tasks_in_development(@user)
    else
      update_tasks_and_user_status_if_have_tasks_in_development(@user)
    end
  end

  private
  attr_accessor :user

  def update_user_status_if_not_have_tasks_in_development(user)
    user.update(status: "inactive")
  end

  def update_tasks_and_user_status_if_have_tasks_in_development(user)
    # if user.tasks.where(status: 'in_development').count != 0
    user.update(status: "inactive") &&
    user.tasks.each{|task| task.update(status: "cancelled")}
    # end
  end
end

# recuperar as tarefas do usuário (ex: uncompleted_tasks)

# contexto 1: 
# se existir tasks incompletas,
# ação: atualizar o status dessas tarefas para "cancelled"
# ação: atualizar o status do usuário para "inactive"

# contexto 2:
# se não existirem tasks incompletas
# ação: atualizar o status para inactive