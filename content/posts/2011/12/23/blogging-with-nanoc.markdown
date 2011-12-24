---
kind: article
created_at: 2011-12-23
title: Blogging With Nanoc

---

# Blogging with Nanoc #

[Nanoc][nanoc] according to its own website:

> nanoc is a Ruby web publishing system for building small to medium-sized websites.

That is exactly what I needed when I was going to create zameermanji.com. I chose Nanoc
over alternatives like [Jekyll][jekyll] because Nanoc was designed to be extensible
and flexible from the start, unlike other tools where it seemed that extensions
and additional configuration were tacked on later.

Nanoc is simple and flexible. At the very core of any Nanoc powered site
is the `Rules` file, which is a ruby file that uses Nanoc's [DSL][dsl] to define compilation
and routing rules. At the time of writing here is the `Rules` file for this site:


~~~~~~~~~~~~~~~~~~~~~~~ {.ruby}
#!/usr/bin/env ruby

require 'compass'
Compass.add_project_configuration 'compass_config.rb'

compile '/assets/stylesheets/*/' do
  filter :sass, Compass.sass_engine_options
end

compile '/assets/javascripts/*/' do
  ext = item[:extension].nil? ? nil : item[:extension].split('.').last
  if ext == 'coffee'
    filter :coffee
    # filter :uglify_js
  elsif ext == "js"
    filter :uglify_js
  else
    raise "Unknown thing #{item.attributes}"
  end
end

compile '*' do
  if item.binary?
    # don’t filter binary items
  else
    ext = item[:extension].nil? ? nil : item[:extension].split('.').last
    if ext == 'haml'
      filter :haml
    elsif ext == 'markdown'
      filter :pandoc
    elsif ext == 'pandoc'
      filter :pandoc
    else
      raise "WHAT IS THIS EXT? While processing #{item.attributes}"
    end

    if item[:layout] != 'none'
      layout "default"
    end
  end
end

route '/assets/stylesheets/*/' do
  item.identifier.chop + '.css'
end

route '/assets/javascripts/*/' do
  item.identifier.chop + '.js'
end

route '*' do
  if item.binary?
    # Write item with identifier /foo/ to /foo.ext
    item.identifier.chop + '.' + item[:extension]
  else
    # Write item with identifier /foo/ to /foo/index.html
    item.identifier + 'index.html'
  end
end

layout '*', :haml
~~~~~~~~~~~~~~~~~~~~~~~





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


