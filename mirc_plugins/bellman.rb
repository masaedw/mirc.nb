def bellman_desc
  "bellman>:今日のベルマンのメニューを吐き出します"
end

def bellman(msg)
  bellman_Menu = %w(休み ハンバーグ トンカツ チキンカツ 冷しゃぶ から揚げ 休み)
  "今日は " + bellman_Menu[Time.now.wday] + " です。"
end
