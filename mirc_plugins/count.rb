def count_desc
  "count>[cnt]: カウントダウンをします。"
end

def count(msg)
  cnt = msg.to_i
  if (cnt > 10)
    return "10カウント以上はダメです。"
  end
  if (cnt == 0)
    cnt = 5
  end

  max = cnt
  for i in 0...max
    notice("#{max-i}")
    sleep(1)
  end

  notice "GO!"
end
