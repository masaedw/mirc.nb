# -*- coding: euc-jp -*-
def _desc
  "s>{pop,push,apply} n: スタックを操作します"
end

def s(msg)
  msgs = msg.split
  @stack ||= []

  case msgs[0]
  when "pop"
    @stack.pop msgs[1]
  when "push"
    @stack.push msgs[1]
  when "apply"
    s_apply
  else
    "なんかおかしいです"
  end
end

def s_apply
  ops = ["+", "-", "*", "/"]
  if @stack.size < 3
    return "オペランドが足りません"
  end

  if ! ops.include? @stack.first
    return "そんなオペレータ知りません #{@stack.first}"
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
end
