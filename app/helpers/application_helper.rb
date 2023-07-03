# frozen_string_literal: true

module ApplicationHelper
  def flash_message
    capture do
      flash.each do |type, message|
        concat(
          content_tag(:div, class: ['flash', type]) do
            content_tag(:span, message) + link_to(svg_icon('x-mark'))
          end
        )
      end
    end
  end
end
