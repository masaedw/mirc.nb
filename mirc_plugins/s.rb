# -*- coding: euc-jp -*-
def s_desc
  "s>{insn}: スタックを操作します/ pop push add sub div mul show tr"
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
  when "add"
    s_do{|a,b| a+b }
  when "sub"
    s_do{|a,b| a-b }
  when "mul"
    s_do{|a,b| a*b }
  when "div"
    s_do{|a,b| a/b }
  when "tr"
    s_do{|a,b| [a,b]}
  when "show"
    "["+@stack.join(", ")+"]"
  else
    "なんかおかしいです"
  end
end

def s_do &block
  n = block.arity
  if @stack.size < n
    return "オペランドが足りません"
  end
  args = Array.new(n){@stack.pop.to_f}
  ret = block.call(*args)
  case ret
  when Array
    @stack += ret
  else
    @stack.push ret
  end
  @stack.last.to_s
end
