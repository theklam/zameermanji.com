require 'pygments.rb'
require 'nokogiri'

class PygmentsFilter < Nanoc3::Filter
  identifier :pygments
  type :text

  def run(content, params = {})
    # The content here should be valid HTML
    # We find code blocks that have been created by pandoc for syntax
    # highlighting. This is a code block with a class name of a programming
    # language.

    # log = ::Nanoc3::CLI::Logger.instance
    # log.color = true

    post = ::Nokogiri::HTML::DocumentFragment.parse(content)
    code_blocks = post.css('pre.ruby code')

    code_blocks.each do |c|
      content = c.content
      content = ::Pygments.highlight(content, :lexer => :ruby, :options => {:lineseparator => '<br/>'})
      content = ::Nokogiri::HTML::DocumentFragment.parse(content)
      pre = content.css('pre').first
      pre.name = 'code'
      c.parent.replace(content)
    end


    # log.log(:high, post.to_s) if code_blocks.size > 0


    post.to_s
  end
end
