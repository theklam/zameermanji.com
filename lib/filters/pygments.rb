require 'pygments.rb'
require 'hpricot'
require 'cgi'

# Note nanoc comes with a pygments.rb filter but I don't
# use it because it doesn't work with pandoc output.

class PygmentsFilter < Nanoc::Filter
  identifier :pygments
  type :text

  def run(content, params = {})
    languages = ['ruby', 'vim', 'python', 'text', 'latex', 'common-lisp', 'bash', 'css']
    languages << 'scala'
    # The content here should be valid HTML
    # We find code blocks that have been created by pandoc for syntax
    # highlighting. This is a code block with a class name of a programming
    # language.

    post = Hpricot(content)

    languages.each do |lang|
      code_blocks = post.search("pre.#{lang} code")
      code_blocks.each do |code_block|
        code = code_block.inner_html
        code = CGI.unescapeHTML(code)
        code = ::Pygments.highlight(code, :lexer => lang, :options => {:encoding => 'utf-8'})
        code_block.parent.swap code
      end
    end

    post.to_html

  end
end
