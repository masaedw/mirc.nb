# from http://www.cyber.sccs.chukyo-u.ac.jp/sirai/classes/nlp/

def dict_desc
  "dict>word: 国語辞典をひきます。"
end

def dict(msg)
  query = toeuc(msg)  # をもらって query に記憶
  # goo ではEUCコードが使われている

  # 検索パタンを作る。「完全一致モード」で日本語辞書を呼び出す
  pat="/search.php?MT=" + query+ "&jn.x=28&jn.y=10&jn=%B9%F1%B8%EC&kind=&mode=1"
  data = http_get("http://dictionary.goo.ne.jp#{pat}")

  doc = Hpricot(data)
  ary = (doc/"div.mainlst").inner_text.to_a
  if ary.size > 2
    ret = ary[1]
  else
    ret = ary.join[0..200]
  end

  if ret.empty?
    "単語が見つかりません。"
  else
    ret
  end
end
