# frozen_string_literal: true

module LayoutHelper
  class SvgNotFound < StandardError; end

  def svg_icon(name, path: nil, classes: '', options: {})
    svg_file = find_svg_file(name, path)

    body   = svg_file.to_s.force_encoding('UTF-8')
    doc    = Nokogiri::HTML::DocumentFragment.parse body
    svg    = doc.at_css 'svg'

    update_icon_attributes(svg, classes:, options:)
    raw doc # rubocop:disable Rails/OutputSafety
  end

  def update_icon_attributes(svg, classes:, options:)
    classes_arrey = classes.is_a?(String) ? classes.split : classes
    svg['class'] = classes_arrey.unshift('icon-svg').join(' ')
    options.each { |k, v| svg[k] = v }
  end

  def find_svg_file(name, path)
    svg_path      = path || 'icons/svg'
    svg_file_path = File.join(svg_path, "#{name}.svg")
    svg_file      = AssetsDetector.find_assets_source(svg_file_path)

    raise SvgNotFound, "Can't find #{svg_file_path}" unless svg_file

    svg_file
  end
end
