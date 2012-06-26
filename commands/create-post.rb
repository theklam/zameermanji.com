require 'to_slug'



usage       'create-post [options]'
aliases     :post
summary     'Creates a post'
description 'Creates a post using the current date and a given title.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

option :t, :title, 'Title', :argument => :required


run do |opts, args, cmd|
  title = opts[:title]

  date = Date.today.strftime("%Y-%m-%d")


  template = <<eos
---
kind: article
created_at: #{date}
title: #{title}

---

eos

  filename = "content/posts/#{title.to_slug}.pandoc"


  File.open(filename, 'w') do |f|
    f.write(template)
  end

  puts "Created #{filename}."

end
