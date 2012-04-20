# This is a LaTeX filter for nanoc

require 'open3'
require 'fileutils'

class LatexFilter < Nanoc::Filter
  identifier :latex
  type :text => :binary

  # Idea, use `latexmk` to do all of the hard work assuming a full
  # MacTeX/TeXLive install.
  def run(content, params={})
    input = ""
    output = ""
    Dir.mktmpdir{|dir|
      input = "#{dir}/doc.tex"
      output = "#{dir}/doc.pdf"
      open(input, "w") {|io|
        io.write(content)
      }

      command = "latexmk -pdf #{input} -aux-directory=#{dir} -output-directory=#{dir}"

      latexmk_output = ''
      latexmk_err = ''
      status = 0
      Open3::popen3(command) do |stdin, stdout, stderr, wait_thr|
        latexmk_output = stdout.read
        latexmk_err = stderr.read
        status = wait_thr.value
      end

      if status.exitstatus != 0
        puts latexmk_output
        puts latexmk_err
        raise "LATEXMK DID NOT EXIT SUCCESSFULLY"
      end

      FileUtils.cp output, output_filename

    }


  end
end
