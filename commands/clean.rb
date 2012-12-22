usage       'clean'
summary     'delete produced files'
description 'Deletes all compilation artifacts.'

flag   :h, :help,  'show help for this command' do |value, cmd|
  puts cmd.help
  exit 0
end

# This is a port of
# nanoc/lib/nanoc/tasks/clean.rake
run do |opts, args, cmd|
  site = Nanoc::Site.new('.')
  if site.nil?
    $stderr.puts 'The current working directory does not seem to be a ' +
                 'valid/complete nanoc site directory; aborting.'
    exit 1
  end

  files = []
  site.items.each do |item|
    item.reps.each do |rep|
      files << rep.raw_path
    end
  end

  $stdout.puts "Deleting files..."

  files.each do |file|
    FileUtils.rm_f file
  end

end
