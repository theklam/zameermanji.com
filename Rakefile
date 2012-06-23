require 'to_slug'

desc "Create A New Post"
task :post do
  title = ENV['TITLE']
  raise "Title Cannot be Nil or Blank" if title.nil? || title == ""


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


end
