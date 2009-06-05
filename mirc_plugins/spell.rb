class MarkovGenerater
  def initialize(filename)
    @next = Hash.new
    @keys = Array.new
    @prefix = "\0"

    File.new(filename).each { |line|
      line.chomp!
      for i in 0...line.length/2
        add(line[i*2,2])
      end
      add("\0")
    }

    @prefix = @keys[rand(@keys.size)]
  end

  def add(str)
    if (@next[@prefix] == nil) then
      @next[@prefix] = [str]
      if (str != "\0") then
        @keys.push(@prefix)
      end
    else
      @next[@prefix].push(str)
    end
    @prefix = str
  end

  def generate
    ret = ""
    key = "\0"
    while (key == "\0")
      key = @keys[rand(@keys.size)]
      if (ENV['QUERY_STRING'] == 'negima') then key = 'ラ' end
    end
    while (key != "\0")
      ret += key
      n = @next[key]
      key = n[rand(n.size)]
    end

    return ret
  end

end

def spell_desc
  "spell>: 魔法を生成します。"
end

def spell(msg)
  spellsFile = "data/spells.txt"
  if (ENV['QUERY_STRING'] == 'negima') then
    spellsFile = "data/spells_negima.txt"
  end

  markov = MarkovGenerater.new(spellsFile)
  spellname = markov.generate()

  adj = [
    '', '小さな', '大きな', '激しく巨大な', 'ほとばしる', '灼熱の', '大',
    '想像を絶する大', '激しい', '身を切り裂く$adj', '全てを切り刻む',
    '大幅に', '全ての', '深い', '1度行った', '弱い'
  ]

  tar = [
    '仲間一人', '仲間全員', '敵', 'マヒ', '毒', '守備力', '攻撃力',
    'MP', '自分', '魔法', '魔法効果', '身', 'バリア', '鉄のかたまり',
    'ダメージ床', '宝箱', 'あやしいもの'
  ]

  pref = [
    '$adj火の玉で', '$adj炎で', '$adj爆発を起こし、', '氷の刃で',
    '$adj竜巻で', '$adj稲妻で', '力を合わせて', '死の言葉を投げかけ',
    'ドラゴンになり炎をはくが、', '命を捨て自爆し、', '命を捨てて',
    '幻で', '1ターンの間だけ', '数ターン'
  ]

  suf = [
    '約$randPtのダメージ', '息の根を止める', '変身している間は我を忘れる',
    '瀕死または戦闘不能にする', 'HPを約$randPt回復', 'HPを$adj回復',
    '$tarを消し去る', '$tarを直す', '$tarを1/2の確率で生き返らせる',
    '$tarを完全に生き返らせる', '$tarを生き返らせる',
    '$tarを遠くにはじき飛ばす', '$tarを消し去る', '$tarを下げる',
    '$tarを二倍にする', '$tarを吸い取る',
    '$tarの受けた$tarの$tarを自分のものにする',
    '$adj$tarを消し去る', '$tarを上げる', '$tarを$adj眠りに誘う',
    '$tarを包む', '$tarを混乱させる', '$tarの$tarを封じ込める',
    '$tarをはね返す', '$tarや$tarから$tarを守る',
    '$tarに対して$tarをはる', '$tarが$tarになる',
    '$adj町や村に移動できる', '建物や洞窟から脱出する',
    '$tarより$adj$tarが出なくなる', '$tarからダメージを受けなくなる',
    '$tarの中身を見極める', '$tarで$tarを発見する', '何が起こるかわからない'
  ]

  msg = suf[rand(suf.size)]
  if (rand(2) < 1) then
    msg = pref[rand(pref.size)] + msg
  end

  while (msg.sub!(/\$adj/, adj[rand(adj.size)]) != nil ||
           msg.sub!(/\$tar/, tar[rand(tar.size)]) != nil ||
           msg.sub!(/\$rand/, (rand(27)*rand(27)).to_s))
  end

  [spellname, msg]
end
