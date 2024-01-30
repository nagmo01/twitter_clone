# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :description, :text
    add_column :users, :place, :text
    add_column :users, :website, :text
    add_column :users, :userid, :text
  end
end
