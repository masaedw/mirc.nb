def yosiyosi_desc
  "yosiyosi>(nick): よしよしします。"
end

def yosiyosi(msg)
  if (rand(10) == 0)
    "#{msg}ヾ( ‥)"
  elsif (rand(10) == 0)
    "#{msg}ヾ(¬_¬)"
  else
    "#{msg}ヾ(‥ )"
  end
end
