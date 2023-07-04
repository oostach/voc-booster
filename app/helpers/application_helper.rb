# frozen_string_literal: true

module ApplicationHelper
  def flash_message
    capture do
      flash.each do |type, message|
        concat(
          content_tag(:div, class: ['flash', 'flex', type]) do
            content_tag(:span, message) + link_to(svg_icon('x-mark', classes: 'icon-sm'), 'javascript:void(0)', class: 'close-button')
          end
        )
      end
    end
  end
end
