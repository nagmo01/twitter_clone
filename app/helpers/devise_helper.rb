# frozen_string_literal: true

module DeviseHelper
  #   def bootstrap_alert(key)
  #     case key
  #     when 'alert'
  #       'warning'
  #     when 'notice'
  #       'success'
  #     when 'error'
  #       'danger'
  #     end
  #   end
  KEYS = {
    'alert' => 'warning',
    'notice' => 'success',
    'error' => 'danger'
  }.freeze

  def bootstrap_alert(key)
    KEYS[key]
  end
end
