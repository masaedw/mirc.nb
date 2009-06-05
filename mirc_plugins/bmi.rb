def bmi_desc
  "bmi>(cm),(kg): BMIを調べます。"
end

def bmi(msg)
  if (msg !~ /^([\d\.]+),([\d\.]+)$/)
    return "bmi>(cm),(kg) という形式で身長と体重を指定して下さい。"
  end
  m = $1.to_f / 100
  kg = $2.to_f
  val = kg / m / m
  "あなたのBMIは #{format('%.3f', val)} です。" +
    if (val < 18.5)
      "痩せすぎです。"
    elsif (val < 25.0)
      "普通です。"
    elsif (val < 30.0)
      "太りすぎです。"
    else
      "肥満です。"
    end
end
