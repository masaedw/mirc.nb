def op_desc
  "op>nick: なるとを配ります。"
end

def op msg
  msg.strip!
  if msg.empty?
    @bot.change_mode(@context.target, "+o", @context.nick)
  else
    msg.split.each do |user|
      @bot.change_mode(@context.target, "+o", user)
    end
  end
  ""
end
