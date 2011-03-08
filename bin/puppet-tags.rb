#!/usr/bin/env ruby

$tags = []

REG_PUPPET_CLASS  = /\s*class\s+([-0-9A-Za-z_:]+)[(]?/
REG_PUPPET_DEFINE = /\s*define\s+([-0-9A-Za-z_:]+)[(]?/
REG_PUPPET_TAG    = Regexp.union([REG_PUPPET_CLASS, REG_PUPPET_DEFINE])
TAG_FORMAT=%!%s\t%s\t/^%s/;"\tf\tclass:dummy\n!

def parse_puppet_syntax(list, fname)
  list.each do |l|
    ret = REG_PUPPET_TAG.match(l)
    if ret
      if ret[1]
        tag = TAG_FORMAT % [ret[1], fname, ret[0]]
      elsif ret[2]
        tag = TAG_FORMAT % [ret[2], fname, ret[0]]
      end
      $tags.push tag
    end
  end
end

def main()

  base = ! $dir.to_s.empty? ? $dir : "./"
  target_dir = File.join([base , '**/*.pp'])

  files = Dir.glob(target_dir)
  if $full_path
    files.map! {|e| File.expand_path(e) }
  end
  files.each do |f|
    parse_puppet_syntax( File.read(f).split("\n"), f)
  end
  puts $tags.sort
end

def help
  puts <<-EOS

 #$0 [-f] [DIR]
 
    -f : fullpath
    DIR: if omitted current directory is used

  EOS
end

if ARGV.delete('-h')
  help
  exit
end

$full_path = ARGV.delete('-f')
$dir = ARGV.pop


main()
