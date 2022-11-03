# frozen_string_literal: true

# 20221102003208_add_status_column_to_user
class AddStatusColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :status, :integer, default: 0
  end
end
