def tukkomi_desc
  "tukkomi>(target): ツッコミkます"
end

def tukkomi(msg)
  tukkomis = [
    'を小一時間問いつめた。',
    'をハリセンで殴った。',
  ]

  if msg == NICK
    Thread.new {
	    notice "hoge"
      sleep 5 
      sayingis = ['スマソ', '嫌プー', '今は反省している']
      notice(kao(sayingis[rand(sayingis.size)]));
    }
  end

  "#{@context.nick}は、#{msg}#{tukkomis[rand(tukkomis.size)]}"
end

