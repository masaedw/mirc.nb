def url_desc
  "url>: このボットの配布先を示します。"
end

def url(msg)
  if (ENV['HOST'] == 'www491.sakura.ne.jp')
    system('./mkpack')
  end
  "http://shinh.skr.jp/koneta/mirc.tar.gz"
end
