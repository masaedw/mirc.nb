require 'uri'

def urlencode_desc
  "urlencode>msg: urlencode"
end

def urlencode(msg)
  URI.encode(msg)
end
