def reminder_desc
  "reminder>(hhmm):(msg): リマインダをセットします。"
end

def reminder(msg)
  if (msg !~ /^\+(\d\d):(.*)/ && msg !~ /^(\d\d)(\d\d):(.*)/)
    return "書式指定が (hhmm):(msg) に従っていません。"
  end

  diff = 0
  ret = ""
  msg = ""
  if ($3)
    h = $1.to_i
    m = $2.to_i
    msg = $3

    if (h > 23 || m > 59)
      return "不適切な時刻指定です。"
    end

    now = Time.now
    diff = ((h-now.hour)*60+(m-now.min))*60-now.sec
    if (diff < 0)
      diff += 60*60*24
    end

    ret = "#{h}時#{m}分に「#{msg}」をお伝えします。"
  else
    diff = 60 * $1.to_i
    msg = $2
    ret = "#{$1.to_i}分後に「#{msg}」をお伝えします。"
  end

  nick = @context.nick

  Thread.new do
    print "create reminder thraed (#{diff}sec)...\n"
    sleep(diff)

    notice("reminder by #{nick}: #{msg}")
  end

  ret
end
