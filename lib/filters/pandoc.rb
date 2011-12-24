# This is a pandoc filter for nanoc>

require 'pandoc-ruby'

class PandocFilter < Nanoc3::Filter
  identifier :pandoc
  type :text

  def run(content, params = {})
    ::PandocRuby.convert(content)
  end
end
