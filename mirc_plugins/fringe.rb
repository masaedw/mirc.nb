def fringe_desc
  "fringe>: ニュースをお知らせします。"
end

def fringe(msg)
  data = http_get('http://cnn.co.jp/fringe/fringe.html')

  lines=data.split(/\n/)            # 行を分割し、配列にいれる

  while (line=lines.shift)
    if (line =~ /<h1>/)
      line = lines.shift
      line =~ /<a href="([^"]+)">([^<]+)<\/a>/
      return [$2, "http://cnn.co.jp#{$1}"]
    end
  end

  "なんかエラーです。"
end
