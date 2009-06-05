def mec_desc
  "mec>:今日の飯をお前らに代わって考えてやるよ"
end

def mec(msg)
  shop = %w(うどん工房 ベルマン あまやん ミンライ)
  "今日は " + shop[rand(shop.length)] + " でいいんじゃね？"
end
