# frozen_string_literal: true

# db/migrate/20220818183111_create_tasks.rb
class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :status
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
