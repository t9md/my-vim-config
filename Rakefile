VIMDIR=File.expand_path('~/.vim')

def ensure_vimdir
  unless File.directory? VIMDIR
    Dir.mkdir VIMDIR
  end
end

def help
  puts
  puts " # Linux"
  puts " rake install os=linux"
  puts
  puts " # Mac"
  puts " rake install os=mac"
  puts
end

task :check do
  $os=ENV['os']
  unless ["mac", "linux"].include? $os
    help
    exit 1
  end
end

task :prepare_config => [:check] do
  ['gvimrc.vim', 'vimrc.vim' ].each do |file|
    s = File.read(file)
    s = s.gsub('git@:github.com:t9md','git://github.com/t9md')
    if $os == "mac"
      s = s.gsub('M-', 'D-')
    end
    outfile = "dot.#{file}"
    File.open(outfile, 'w') { |f| f.puts(s) }
  end
end

desc "install"
task :install => [:check, :prepare_config ] do
  ensure_vimdir
  sh "mv dot.gvimrc ~/.gvimrc"
  sh "mv dot.vimrc  ~/.vimrc"
  sh "cp -r ./vim ~/.vim"
end
