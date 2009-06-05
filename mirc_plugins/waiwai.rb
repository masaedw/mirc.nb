def waiwai_desc
  "waiwai>[msg]: ¤ï¡¼¤¤¡£"
end

def waiwai(msg)
  if (rand(50) == 0)
    "¥Î)`¡¼¡­(¡³  #{msg}"
  else
    "¡³( ¡­¡¼`)¥Î  #{msg}"
  end
end
