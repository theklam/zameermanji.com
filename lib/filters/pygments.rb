require 'pygments.rb'
require 'hpricot'
require 'cgi'

class PygmentsFilter < Nanoc3::Filter
  identifier :pygments
  type :text

  def run(content, params = {})
    # The content here should be valid HTML
    # We find code blocks that have been created by pandoc for syntax
    # highlighting. This is a code block with a class name of a programming
    # language.

    log = ::Nanoc3::CLI::Logger.instance
    log.color = true

    post = Hpricot(content)
    code_blocks = post.search('pre.ruby code')
    code_blocks.each do |code_block|
      code = code_block.inner_html
      code = CGI.unescapeHTML(code)
      code = ::Pygments.highlight(code, :lexer => 'ruby', :options => {:lineseparator => '<br>', :encoding => 'utf-8'})
      log.log(:high, code)
      code_block.parent.swap code
    end

    post.to_html

  end
end
