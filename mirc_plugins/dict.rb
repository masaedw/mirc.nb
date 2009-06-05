# from http://www.cyber.sccs.chukyo-u.ac.jp/sirai/classes/nlp/

def dict_desc
  "dict>word: 国語辞書をひきます。"
end

def dict(msg)
  query = URI.encode(msg.toutf8)
  # goo ではutf8が使われている

  # 検索パタンを作る。「完全一致モード」で国語辞書を呼び出す
  url = "http://dictionary.goo.ne.jp/freewordsearcher.html?MT=#{query}&mode=1&id=top&kind=jn"
  data = open(url).read
  @logger.slog url

  doc = Hpricot(data)
  ary = (doc/".wordDefinition").inner_text.gsub("&nbsp;", " ").
    gsub("━━", "\n━━").toeuc.to_a

  if !ary.empty?
    return ary
  end

  ary = (doc/".resultList").inner_text.gsub("&nbsp;", " ").
    gsub("━━", "\n━━").toeuc.to_a

  if ary.empty?
    "単語が見つかりません。"
  else
    ary
  end
end
