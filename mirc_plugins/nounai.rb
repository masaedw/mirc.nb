require 'cgi'

def nounai_desc
  "nounai>: 脳内メーカーのURLを表示します。"
end

def nounai(msg)
  if msg == ""
    msg = @context.nick
  end

  "http://maker.usoko.net/nounai/r/#{CGI.escape(toeuc(msg))}"
end
