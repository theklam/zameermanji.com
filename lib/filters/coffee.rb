# This creates a coffee-script filter for nanoc
# Note that nanoc 3.3 comes with a CS filter, so I should
# remove this then.

require 'coffee-script'

class CoffeeScriptFilter < Nanoc3::Filter
  identifier :coffee
  type :text

  def run(content, params = {})
    ::CoffeeScript.compile(content)
  end
end
