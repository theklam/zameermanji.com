# This is a pandoc filter for nanoc

require 'pandoc-ruby'

class PandocFilter < Nanoc::Filter
  identifier :pandoc
  type :text

  def run(content, params = {})
    ::PandocRuby.convert(content, 'smart')
  end
end
