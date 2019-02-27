require 'date'
require 'json'
require 'uri'

def handler(event:, context:)
  project = ENV['PROJECT']    
  today = Date.today
  to = project + '/'
  to +=  "#{today.strftime('%Y%%2F%m%%2F%d')}"
  body = "\n\n\n##{%w(日 月 火 水 木 金 土)[today.wday]}曜日 #nippo"
  to += "?body=#{URI.encode(body)}"
  { location: to }
end
