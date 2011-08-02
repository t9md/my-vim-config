VIMDIR = File.expand_path('~/.vim')

task :default => "help"

task :help do
  puts
  puts " rake install"
  puts
end

$files = %w(
)

VIMDIR_SRC     = File.expand_path("~/Dropbox/vim")
VIMDIR_PREPARE = File.expand_path("./vim")
desc "prepare"
task :prepare do
  sh "rm -rf #{VIMDIR_PREPARE}"
  sh "mkdir #{VIMDIR_PREPARE}"
  Dir.chdir VIMDIR_PREPARE do
    src_dirs = %w( syntax autoload colors plugin after ftdetect).map {|f|
      File.join(VIMDIR_SRC, f)
    }
    src_dirs.each do |dir|
      sh "cp -r #{dir} #{VIMDIR_PREPARE}/"
    end
    %w(bundle doc quicktag tryit phrase).each do |dir|
      sh "mkdir #{dir}"
    end
  end

  sh "unzip -q vimdoc_ja*zip"
  sh "mv runtime/doc/* vim/doc/"
  sh "mv runtime/syntax/* vim/syntax/"
  sh "rm -rf runtime"

  %w( 
      ~/Dropbox/vim/gvimrc_linux.vim
      ~/Dropbox/vim/vimrc_linux.vim 
  ).each do |f|
    cp File.expand_path(f), '.', :verbose => true
  end
end

desc "build"
task :build do
  ['gvimrc_linux.vim', 'vimrc_linux.vim' ].each do |file|
    s = File.read(file)
    s = s.gsub('git@github.com:t9md/','t9md/')
    s = s.gsub('M-', 'D-')
    outfile = file.sub('_linux','_mac')
    File.open(outfile, 'w') { |f| f.puts(s) }
  end
end

desc "install"
task :install do
  unless File.directory? VIMDIR
    Dir.mkdir VIMDIR
  end

  os = case RUBY_PLATFORM
       when /linux/ then "linux"
       when /darwin/ then "mac"
       end

  if os.nil?
    warn "\n'mac' and 'linux' are only supprted\n"
    exit 1
  end

  sh "cp vimrc_#{os}.vim", "~/.vimrc", :verbose => true
  sh "cp gvimrc_#{os}.vim", "~/.gvimrc", :verbose => true
end
