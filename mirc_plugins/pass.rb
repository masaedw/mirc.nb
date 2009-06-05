# -*- coding: euc-jp -*-

def log_password_file; "/home/muto/.htpasswd" end
def log_user; "tucc" end
def htpasswdcmd; "/usr/local/apache2/bin/htpasswd" end

def pass_desc
  "pass>[pass]: ログ閲覧用パスワードを確認/設定します。"
end

def target_notice target, msg
  @bot.send_notice(target, e2j(msg).delete("\r\n")) if msg
end

def pass msg
  msg.strip!
  if msg.empty?
    if @pass.nil? || @pass.empty?
      "パスワード忘れました。適当に設定してください。"
    else
      ["現在のパスワードは 「#{@pass}」",
       "ユーザ名は tucc",
       "http://tucc.aa0.netvolante.jp/~muto/logs/today-tucc.txt",
       "http://tucc.aa0.netvolante.jp/~muto/logs/yesterday-tucc.txt",
       "パスワードはそんなに変更されないので、ブラウザのパスワード保存機能を使うのがおすすめです。"
      ].each do |msg|
        target_notice(@context.nick, msg)
      end
      ""
    end
  else
    @pass = msg
    #if system("/usr/sbin/htpasswd2", "-b", log_password_file, log_user, msg)
    if system(htpasswdcmd, "-b", log_password_file, log_user, msg)
      "パスワードを更新しました #{msg}"
    else
      "なんかエラーです"
    end
  end
end
