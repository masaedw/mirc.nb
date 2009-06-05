def date_desc
  "date>: 時間を言います。"
end

def date(msg)
  `date`.toeuc.chomp
end
