# frozen_string_literal: true

module ApplicationHelper
  def flash_class(key)
    case key.to_s
    when 'notice'
      'success'
    when 'alert'
      'danger'
    else
      'default'
    end
  end
end
