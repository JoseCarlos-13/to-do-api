# frozen_string_literal: true

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
