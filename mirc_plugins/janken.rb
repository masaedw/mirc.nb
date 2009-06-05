def janken_desc
  "janken>(gcp)じゃんけんぽん"
end

def janken(msg)
  if /\s*^([gcp])/ =~ msg
    x = $1
    k = {"g" => "p", "c" => "g", "p" => "c"}
    m = {"g" => "c", "c" => "p", "p" => "g"}
    case rand(10)
    when 0,1,2,3
      "オレの手は#{x}!! あいこですお"
    when 4,5,6,7,8
      "オレの手は#{k[x]}!! m9（＾Д＾）プギャーm9（＾Д＾）プギャーm9（＾Д＾）プギャーm9（＾Д＾）プギャー"
    when 9
      "オレの手は#{m[x]}!! オマエの勝ちだ。認めんぞお！"
    end
  else
    "gcpのどれかを出す"
  end
end
