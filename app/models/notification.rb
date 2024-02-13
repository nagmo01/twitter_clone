# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :visitor, class_name: 'User', dependent: :destroy
  belongs_to :visited, class_name: 'User', dependent: :destroy

  belongs_to :tweet, optional: true
  belongs_to :reply, optional: true
end
