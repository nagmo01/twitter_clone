# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: 'sent_messages'
  belongs_to :receiver, class_name: 'User', inverse_of: 'received_messages'

  scope :my_messages, -> (current_user) { 
  where(sender_id: current_user.id)
  .or(where(receiver_id: current_user.id))
  .select('DISTINCT ON (sender_id, receiver_id) *')
  .order('sender_id, receiver_id, created_at DESC') 
}
end
