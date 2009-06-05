def war_filter msg
  if /戦争/ =~ msg.toeuc
    "なぜ人は争うのか"
  end
end
