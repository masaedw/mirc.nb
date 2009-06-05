def tooexcite_desc
  "tooexcite>words: words をエキサイトすぎ翻訳します。"
end

require 'net/http'
require 'uri'

def tooexcite(msg)
  Net::HTTP.version_1_2

  Net::HTTP.start('www.excite.co.jp', 80) {|http|
    src = URI.encode(msg.toutf8)
    res = http.post("/world/chinese/", "before=#{src}&wb_lp=CHJA&big5=no&start=")
    /name="after"[^>]*>([^<]*)<\/textarea/ =~ res.body
    $1.toeuc
  }
end
