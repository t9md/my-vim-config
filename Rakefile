require 'rake/clean'
VIMDIR = File.expand_path('~/.vim')

task :default => "help"

task :help do
  puts
  puts " rake install"
  puts
end

VIMDIR_SRC     = File.expand_path("~/Dropbox/vim")
VIMDIR_PREPARE = File.expand_path("./vim")

CLEAN << FileList['*.tmp','*.vim', 'vim'].exclude("vimrc.local.vim")

desc "build_all"
task :build_all => [:clean, :prepare, :build]

desc "prepare"
task :prepare do
  mkdir VIMDIR_PREPARE
  Dir.chdir VIMDIR_PREPARE do
    src_dirs = %w( syntax autoload colors after ftdetect).map {|f|
      File.join(VIMDIR_SRC, f)
    }
    src_dirs.each do |dir|
      sh "cp -r #{dir} #{VIMDIR_PREPARE}/"
    end
    %w(bundle plugin doc quicktag tryit phrase).each do |dir|
      mkdir dir
    end
    cp "#{VIMDIR_SRC}/plugin/misc.vim", "plugin/"
  end

  sh "unzip -q vimdoc_ja*zip"
  sh "mv runtime/doc/* vim/doc/"
  sh "mv runtime/syntax/* vim/syntax/"
  sh "rm -rf runtime"

  vimrc = %w( gvimrc_linux.vim vimrc_linux.vim  ).map { |f| File.join(VIMDIR_SRC, f) }
  vimrc.each do |f|
    puts f
    cp f, "#{File.basename(f)}.tmp" , :verbose => true
  end
end

desc "build"
task :build do
  ['gvimrc_linux.vim.tmp', 'vimrc_linux.vim.tmp' ].each do |file|
    s = File.read(file)
    s = s.gsub('git@github.com:t9md','t9md').gsub(/\.git$/,'')
    linux_file = File.basename(file, ".tmp")
    mac_file = linux_file.sub('_linux','_mac')

    File.open(linux_file, 'w') { |f| f.puts s }
    File.open(mac_file  , 'w') do |f|
      f.puts s.gsub(/(<|-)(M-)/) { $1 + "D-" }
    end
  end
end

desc "install"
task :install do
  Dir.mkdir VIMDIR unless File.directory? VIMDIR

  os = case RUBY_PLATFORM
       when /linux/ then "linux"
       when /darwin/ then "mac"
       end

  if os.nil?
    warn "\n'mac' and 'linux' are only supprted\n"
    exit 1
  end

  cp "vimrc_#{os}.vim" , "~/.vimrc"          , :verbose => true
  cp "gvimrc_#{os}.vim", "~/.gvimrc"         , :verbose => true
  cp "vimrc.local.vim" , "~/.vimrc.local.vim", :verbose => true
  cp_r "vim/*"         , "~/.vim/"
end
