# frozen_string_literal: true
module ApplicationHelper
  def flash_message
    capture do
      flash.each do |type, message|
        concat content_tag(:div, message, class: ['flash', type])
      end
    end
  end
end
