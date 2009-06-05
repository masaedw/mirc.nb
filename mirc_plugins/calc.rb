def calc_desc
  "calc>(formula): 電卓です。"
end

def calc(msg)
  if (msg !~ /^[*\d+-\/()\. %]+$/)
    "計算式が正しくないです"
  elsif (msg =~ /\*\*/)
    "とりあえず累乗はカンベンしてください"
  else
    begin
      ret = `ruby -e 'print #{msg}'`
      if (ret == '')
        "エラーっぽいです"
      else
        ret
      end
    rescue
      "なんかエラーです"
    end
  end
end
