VIMDIR=File.expand_path('~/.vim')

def transform(platform)
  ['gvimrc.vim', 'vimrc.vim' ].each do |file|
    s = File.read(file)
    s = s.gsub('git@:github.com:t9md','git://github.com/t9md')
    if platform == :mac
      s = s.gsub('M-', 'D-')
    end
    outfile = "dot.#{file}"
    File.open(outfile, 'w') { |f| f.puts(s) }
  end
end

def vim_config_install
  sh "cp #{dot.gvimrc} ~/.gvimrc"
  sh "cp #{dot.vimrc}  ~/.vimrc"
  sh "cp -r ./vim ~/.vim"
end

def ensure_vimdir
  unless File.directory? VIMDIR
    Dir.mkdir VIMDIR
  end
end

desc "install linux"
task :install_linux => [:genrc] do
  ensure_vimdir
  transform(:linux)
  vim_config_install
end

desc "install mac"
task :install_mac => [:gen_mac] do
  ensure_vimdir
  transform(:mac)
  vim_config_install
end
