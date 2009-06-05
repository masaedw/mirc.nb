def harakiri_desc
  "harakiri>(target): 腹を切って死にます。介錯はtargetに頼みましょう"
end

def harakiri(msg)
  tamerai = rand(4) + 1

  case
  when (tamerai % 3) == 0
    "#{@context.nick}はためらった。"

  when msg.empty?
    sleep(tamerai)
    ["ハラキリー",
     "#{@context.nick}は腹を切った。"]

  else
    notice("#{msg}よ…介錯を頼む…")
    sleep(tamerai)
    ["ハラキリー!!!",
     "#{@context.nick}は腹を切った。",
     "#{msg}＜さすがの俺でもそれは引くわ（；＾ω＾）"]
  end
end
