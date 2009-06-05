def version_desc
  "version>: バージョンを表示する。"
end

def version(msg)
  line = `cd plugins; svn log | head -2 | tail -1`
  line =~ /^(r\d+) \| \S+ \| (\d+-\d+-\d+)/
  rev = $1
  date = $2

  version = %Q(ruby-#{RUBY_VERSION} (#{RUBY_RELEASE_DATE}))
  if defined?(RUBY_VM_REV)
    version += %Q( YARVCore-r#{RUBY_VM_REV} (#{RUBY_VM_DATE}))
  end
  version += " [#{RUBY_PLATFORM}]"

  "mirc-#{rev} (#{date}) #{version}"
end
