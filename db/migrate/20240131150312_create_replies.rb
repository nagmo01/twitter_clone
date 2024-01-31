# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.references :tweet, null: false
      t.text :content, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
