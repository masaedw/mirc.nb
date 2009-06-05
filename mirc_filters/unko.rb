# -*- coding: euc-jp -*-
def unko msg
  endr = "([ 　!！…・。.,、?？っッ＾^〜ーー]*)"
  case j2e(msg).strip
  when /う[〜ー]*ん#{endr}$/e
    sleep(0.8)
    "こ#{$1}"
  when /ウ[〜ー]*ン#{endr}$/e
    sleep(0.8)
    "コ#{$1}"
  when /ちー*ん#{endr}$/e
    kao("大丈夫か？")
  when /チー*ン#{endr}$/e
    "もういいから……"
  when /^まー*ん#{endr}$/e
    kao("楽しい？")
  when /^マー*ン#{endr}$/e
    "……"
  when /ぬるぽ|ヌルポ#{endr}/e
    kao("ガッ!#{$1}")
  when /どう(み|見)ても.+です/e
    kao("本当にありがとうございました。")
#  when /^[*\d+-\/()\. %]+$/
#    calc(msg)
  end
end
