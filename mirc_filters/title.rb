require 'rubygems'
require 'mechanize'

def title msg
  if %r|(http://[^\s]*)| =~ msg
    agent = WWW::Mechanize.new
    begin
      page = agent.get($1)
      if /html/ =~ page.header["content-type"] && page.title
        toeuc(page.title)
      end
    rescue WWW::Mechanize::ResponseCodeError
    end
  end
end
