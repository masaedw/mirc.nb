def help_desc
  "help>[cmd]: このヘルプを表示します"
end

def help(msg)
  if (msg == "")
    ret = Array.new
	ret.push("help>[cmd] で cmd のヘルプを表示できます。コマンドは以下の通り。")
	ret.push(@plugins.keys.join(', '))
    ret
  else
    if (@plugins.key?(msg))
	  @plugins[msg][0]
	else
	  "#{msg}: そんなコマンドはありません"
	end
  end
end

