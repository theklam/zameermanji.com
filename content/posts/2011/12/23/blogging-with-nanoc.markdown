---
kind: article
created_at: 2011-12-23
title: Blogging With Nanoc

---
I've finally made the move to a static blog engine and I am using [Nanoc][nanoc].
I chose nanoc because it met 90% of my requirements and adding the last 10% was
trivial.

My requirements for this site was to create all posts in [Pandoc][pandoc] flavored
markdown, use HAML for layouts and other pages, and use [Pygments][pygments]
for syntax highlighting in posts. Nanoc enabled me to do all of that very easily even though
it did not support Pandoc out of the box.

At the very core of any Nanoc powered site
is the `Rules` file, which is a ruby file that uses Nanoc's [DSL][dsl] to define `compile`
and `route` rules for items. An "item" is any file on your website, it can be a markdown file,
an image, RSS feed or CofeeScript file. The `compile` rules are used to define the transformations
on the content of a file to get the output. These transformations are defined in filters.
The `route` rules are used to determine the filenames of the compiled content
and where it should be placed in the final directory structure. Here is an example
compile rule which is used to compile the posts on this website.

~~~~~~~~~~~~~~~~~~~~~~~ {.ruby}
compile '*' do
  if item.binary?
    # don’t filter binary items
  else
    ext = item[:extension].nil? ? nil : item[:extension].split('.').last
    if ext == 'haml'
      filter :haml
    elsif ext == 'markdown'
      filter :pandoc
      filter :pygments
    else
      raise "Unknown ext #{ext} While processing #{item.attributes}"
    end

    if item[:layout] != 'none'
      layout "default"
    end
  end
end
~~~~~~~~~~~~~~~~~~~~~~~

Based on the file extension of the item, I pipe it through appropriate set of filters
to get the desired HTML. I also then place the item in my default layout to produce the final page.
Above, I use two filters that I wrote, the `pandoc` filter and the `pygments` filter to
generate the appropriate html. Nanoc comes with many [filters][filters-list] but it is also
very easy to [write your own][own-filter]. As an example look at my Pandoc filter.

~~~~~~~~~~~~~~~~~~~~~~~ {.ruby}
require 'pandoc-ruby'

class PandocFilter < Nanoc3::Filter
  identifier :pandoc
  type :text

  def run(content, params = {})
    ::PandocRuby.convert(content, 'smart')
  end
end
~~~~~~~~~~~~~~~~~~~~~~~

All I had to do was specify the name of the filter, what the expected input
and output was, and a method that would take in the input text and return the output
text. The filter makes use of the excellent [pandoc-ruby][pandoc-ruby] gem to invoke
the Pandoc binary.



[nanoc]: http://nanoc.stoneship.org/
[dsl]: http://nanoc.stoneship.org/docs/api/3.2/Nanoc3/CompilerDSL.html
[pandoc]: http://johnmacfarlane.net/pandoc/
[pygments]: http://pygments.org/
[pandoc-ruby]: https://github.com/alphabetum/pandoc-ruby
[filters-list]: http://nanoc.stoneship.org/docs/4-basic-concepts/#filters
[own-filter]: http://nanoc.stoneship.org/docs/5-advanced-concepts/#writing-filters
