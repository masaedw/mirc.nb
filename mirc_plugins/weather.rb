def weather_desc
  "weather>: 徳島県北部の天気予報をお知らせします。"
end

def weather(msg)
  #data = http_get('http://weather.yahoo.co.jp/weather/jp/13/4410.html')
  data = http_get('http://weather.yahoo.co.jp/weather/jp/36/7110.html')

  lines=data.split(/\n/)            # 行を分割し、配列にいれる

  body=""

  colon = false
  saiko = false

  ret = Array.new

  while (line=lines.shift)
    if (/<tr align=center><td><b>([^<]*)<\/b><\/td><\/tr>$/ =~ line)
      body += "#{$1} "
      colon = true
    end
    if (colon && /^<small>([^<]*)<\/small>$/ =~ line)
      body += "#{$1}"
      colon = false
    end
	if (/\]<br>([\d]+|---)\s*$/ =~ line)
	  body += " #{$1}度"
	  if (saiko)
	    ret.push(body)
	    saiko = false
		body = ''
	  else
	    saiko = true
	  end
	end
  end

  ret
end
