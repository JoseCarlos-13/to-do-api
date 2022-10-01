# frozen_string_literal: true

# 20221001212652_add_user_references_to_tasks
class AddUserReferencesToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
  end
end
