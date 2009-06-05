# from http://www.cyber.sccs.chukyo-u.ac.jp/sirai/classes/nlp/
require 'rubygems'
require 'hpricot'
require 'nkf'

def je_desc
  "je>word: 和英辞書をひきます。"
end

def je(msg)
  query = URI.encode(msg.toutf8)
  # goo ではutf8が使われている

  # 検索パタンを作る。「完全一致モード」で和英辞書を呼び出す
  url = "http://dictionary.goo.ne.jp/freewordsearcher.html?MT=#{query}&mode=1&id=top&kind=je"
  data = open(url).read

  doc = Hpricot(data)
  ary = (doc/".ja-enResultArea").inner_text.gsub("&nbsp;", " ").
    gsub("━━", "\n━━").toeuc.to_a

  if ary.empty?
    "単語が見つかりません。"
  else
    ary
  end
end

