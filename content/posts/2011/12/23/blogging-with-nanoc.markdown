---
kind: article
created_at: 2011-12-23
title: Blogging With Nanoc

---

[Nanoc][nanoc] according to its own website:

> nanoc is a Ruby web publishing system for building small to medium-sized websites.

That is exactly what I needed when I was going to create zameermanji.com. I chose Nanoc
over alternatives like [Jekyll][jekyll] because Nanoc was designed to be extensible
and flexible from the start, unlike other tools where it seemed that extensions
and additional configuration were tacked on later.

Nanoc is simple and flexible. At the very core of any Nanoc powered site
is the `Rules` file, which is a ruby file that uses Nanoc's [DSL][dsl] to define `compile`
and `route` rules. The `compile` rules are used to define the steps needed to transform
an input file to an output file. In this site that is typically pandoc flavored
markdown to html. Here are the relevant lines from my `Rules` file.


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

Here I take all of the text files I have in my site and if they match a certain
extension they are piped through one more more nanoc filters. Nanoc fitlters
simply take in text and out put text. Above for `haml` files the haml filter
takes in haml markup and outputs html. For markdown files I am transforming it
to html by my pandoc filter and then using my pygments filter to add syntax
highlighting to code snippets in the post.



[jekyll]: https://github.com/mojombo/jekyll
[nanoc]: http://nanoc.stoneship.org/
[dsl]: http://nanoc.stoneship.org/docs/api/3.2/Nanoc3/CompilerDSL.html




<!-- Nanoc is stupidly simple and flexible. Compared to [Jekyll][jekyll] and [Octopress][octopres], -->
<!-- it was designed for extensibility right out of the box. It is also really easy to configure. -->

<!-- ## My Configuration ## -->

<!-- ## Extending Nanoc ## -->



<!-- When I first set forward to create zameermanji.com -->

<!-- When I was creating zameermanji.com I thought it would be nice to make it a static site -->
<!-- and have a blog to go with it. -->


<!-- My first choice was to go with [Jekyll][jekyll] -->
<!-- which is *the* static site generator for programmers. I noticed however hat Jekyll -->
<!-- is very blog centric and didn't jive with my mental model on how a static site generator -->
<!-- should function. I then discovered [Nanoc][nanoc] which really fits with my mental model. -->


