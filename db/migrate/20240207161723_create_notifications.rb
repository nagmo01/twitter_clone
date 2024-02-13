# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :tweet_id
      t.integer :reply_id
      t.string :action_type, null: false, default: ''
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
