# -*- coding: euc-jp -*-
def s_desc
  "s>{pop,push,apply}: スタックを操作します"
end

def s(msg)
  msgs = msg.split
  @stack ||= []

  case msgs[0]
  when "pop"
    @stack.pop.to_s
  when "push"
    @stack.push msgs[1]
    @stack.last
  when "apply"
    s_apply
  when "show"
    "["+@stack.join(", ")+"]"
  else
    "なんかおかしいです"
  end
end

def s_apply
  ops = ["+", "-", "*", "/"]
  if @stack.size < 3
    return "オペランドが足りません"
  end

  if ! ops.include? @stack.last
    return "そんなオペレータ知りません #{@stack.last}"
  end

  op = @stack.pop
  a = @stack.pop.to_f
  b = @stack.pop.to_f

  @stack.push case op
              when "+"
                a + b
              when "-"
                a - b
              when "*"
                a * b
              when "/"
                a / b
              end
  @stack.last.to_s
end
