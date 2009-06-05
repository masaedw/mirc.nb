require 'enumerator'
require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'nkf'
require 'kconv'

def oricon_desc
  ["oricon>(genre)[/(period=m)] [cond=..10]: オリコンランキングを調べます",
   "genre :",
   "js: 邦楽シングル",
   "ja: 邦楽アルバム",
   "wa: 洋楽アルバム",
   "is: インディーズシングル",
   "ia: インディーズアルバム",
   "an: アニメ",
   "",
   "period : 指定が無い場合、 m と見なします",
   "d: デイリー",
   "w: 週間",
   "m: 月間  [標準]",
   "",
   "cond : 指定が無い場合、 ..10 と見なします",
   "N: N位を表示",
   "..N: 上位N位を表示",
   "N..M: N位からM位までを表示"]
end

def onkf str
  t = NKF.nkf("-Z1e", str)
  if t.empty? # 薔薇架刑 (ALI PROJECT) が消えてしまう問題への暫定的な対処
    str
  else
    t
  end
end

def oget elem
  onkf(elem.inner_text.delete("\n\r")).strip
end

def oricon(msg)
  genre = %w(js ja wa is ia an)
  period = %w(d w m)

  case msg
  when /(\w\w)\/(\w)/
    g = $1
    p = $2
  when /(\w\w)/
    g = $1
    p = "m"
  else
    return ["書式が違います", "アニメのランキングみたいときは、", "oricon>an", "だよv おにいちゃんv"]
  end

  unless genre.include?(g) && period.include?(p)
    return ["指定がおかしいです", "アニメのランキングみたいときは、", "oricon>an", "だよv おにいちゃんv"]
  end

  case msg.split[1]
  when /(\d+)\.\.(\d+)/
    s = $1.to_i - 1
    e = $2.to_i - 1
    range = s..e
  when /\.\.(\d+)/
    e = $1.to_i - 1
    range = 0..e
  when /(\d+)/
    range = $1.to_i - 1
  else
    range = 0..9
  end

  body = http_get("http://www.oricon.co.jp/rank/#{g}/#{p}/")
  doc = Hpricot(body)

  ranking_name = oget(doc/"title")
  updateday = oget((doc/".updateday td").first ||
                   (doc/".updateday").first ||
                   (doc/".inner_updateday"))
  top_title = oget(doc/".top_topics h2")
  top_artist = oget(doc/".top_topics h3")

  ranking = ["   1.  #{top_title} 【#{top_artist}】"]

  (doc/"h4").map{|i| oget(i)}.enum_for(:each_slice, 2).each_with_index do |v, i|
    title, artist = v
    s = "%4d.  %s 【%s】" % [i+2, title, artist]
    ranking.push(s)
  end

  if range.is_a?(Numeric) && ranking.size <= range
    return "#{ranking.size}位までしかデータがないです"
  end

  ranking = ranking[range]
  if ranking.is_a? Array
    ranking.unshift((ranking_name+" "+updateday))
  else
    [(ranking_name+" "+updateday), ranking]
  end
end

if $0 == __FILE__
  def http_get url
    open(url).read
  end
  puts(oricon("").join("\n")); puts
  puts(oricon("js").join("\n")); puts
  puts(oricon("ja").join("\n")); puts
  puts(oricon("wa").join("\n")); puts
  puts(oricon("is").join("\n")); puts
  puts(oricon("ia").join("\n")); puts
  puts(oricon("an").join("\n"))
end
