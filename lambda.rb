require 'date'
require 'json'
require 'uri'
require 'aws-sdk-lambda'

LASTORDER = ENV['lastOrder']

def handler(event:, context:)
  project = ENV['PROJECT']    
  today = Date.today
  to = project + '/'
  to +=  "#{today.strftime('%Y%%2F%m%%2F%d')}"

  client = Aws::Lambda::Client.new
  res = client.invoke({
    function_name: LASTORDER,
    payload: {
      name: 'sb-nippo-kaku-lambda'
    }.to_json
  })
  result = JSON.parse(res.payload.string)
  last = result['last']
  if last.nil? || today.strftime('%D') != Time.at(last.to_i).strftime('%D')
    body = "K\nP\nT\n\n"
    body += "##{%w(日 月 火 水 木 金 土)[today.wday]}曜日 #nippo"
    to += "?body=#{URI.encode(body)}"
  end
  { location: to }
end
