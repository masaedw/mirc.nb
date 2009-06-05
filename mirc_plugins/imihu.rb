def imihu_desc
  "imihu>[msg]: よくわからん顔文字を出します。"
end

def imihu(msg)
  if (rand(10) == 0)
    "ヽ'∀';ノ #{msg}"
  else
    "ヽ'∀'ノ #{msg}"
  end
end
