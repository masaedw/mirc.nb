# from http://www.cyber.sccs.chukyo-u.ac.jp/sirai/classes/nlp/
require 'rubygems'
require 'hpricot'
require 'nkf'

def je_desc
  "je>word: 和英辞典をひきます。"
end

def je(msg)
  query = URI.encode(toeuc(msg))
  # goo ではEUCコードが使われている

  # 検索パタンを作る。「完全一致モード」で日本語辞書を呼び出す
  pat="/search.php?MT=" + query+ "&je.x=24&je.y=12&kind=je&mode=1"
  data = http_get("http://dictionary.goo.ne.jp#{pat}")

  doc = Hpricot(data)
#   ary = (doc/"div.mainlst").inner_text.gsub("&nbsp;", " ").
#     gsub("━━", "\n----").gsub("）", ") ").gsub("（", " (").
#     gsub("【", " [[").gsub("】", "]] ").to_a
#   ary = ary.map{|i| i.strip}.delete_if{|i| i.empty? || /^----/ !~ i}
  mainlst = (doc/"div.mainlst")
  (mainlst/"br").map{|i| i.swap("\n")}
  ary = mainlst.inner_text.gsub("&nbsp;", " ").to_a.map{|i| i.strip}.delete_if{|i| i.empty?}

  if ary.empty?
    "単語が見つかりません。"
  else
    ary
  end
end

