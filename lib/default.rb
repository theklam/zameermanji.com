# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Capturing
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::XMLSitemap

require "loofah"

# A scrubbing helper for clean :title tags
def scrub_title(title)
  ::Loofah.fragment(title).scrub!(:strip).text
end
