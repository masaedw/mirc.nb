def jw_desc
  "mec>:output jw's action of today"
end

def jw(msg)
  action = %w(labo jikka ma-jan game Hentai-game 2ch karaoke)
  "jw's today action is " + action[rand(action.length)] + " :-) "
end
