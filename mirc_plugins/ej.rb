# from http://www.cyber.sccs.chukyo-u.ac.jp/sirai/classes/nlp/
require 'rubygems'
require 'hpricot'
require 'nkf'

def ej_desc
  "ej>word: 英和辞典をひきます。"
end

def ej(msg)
  query = toeuc(msg)
  # goo ではEUCコードが使われている

  # 検索パタンを作る。「完全一致モード」で日本語辞書を呼び出す
  pat="/search.php?MT=" + query+ "&kind=ej&mode=1"
  data = http_get("http://dictionary.goo.ne.jp#{pat}")

  doc = Hpricot(data)
#   ary = (doc/"div.mainlst").inner_text.gsub("&nbsp;", " ").
#     gsub("━━", "\n----").gsub("）", ") ").gsub("（", " (").
#     gsub("【", " [[").gsub("】", "]] ").to_a
#   ary = ary.map{|i| i.strip}.delete_if{|i| i.empty? || /^----/ !~ i}
  ary = (doc/"div.mainlst").inner_text.gsub("&nbsp;", " ").
    gsub("━━", "\n━━").to_a
  ary = ary.map{|i| i.strip}.delete_if{|i| i.empty? || /^━━/ !~ i}

  if ary.empty?
    "単語が見つかりません。"
  else
    ary
  end
end

