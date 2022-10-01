# frozen_string_literal: true

# 20221001205555_add_user_to_tasks
class AddUserToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :user_id, :reference
  end
end
