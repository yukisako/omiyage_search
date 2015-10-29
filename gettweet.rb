require 'twitter'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "AHnpTjmcn3SYm04SxenbnJm0F"
  config.consumer_secret     = "YlPl8NU0qYMv6ip7tOn1qB6JoGoY5nbsbzBgY7ZjB8Z2CmIUvi"
  config.access_token        = "3381861793-DXtc7WIiMq0OeyGvprp5zpR2uEI5HaxJRpVzWQ3"
  config.access_token_secret = "Isj9EIlnOlMMENbCGowduzcDUlD1KXuAXYZdDeToGgEQe"
end


# 特定ユーザのtimelineを件数指定して取得
@client.user_timeline("yuki_99_s", { count: 10 } ).each do |timeline|
  puts @client.status(timeline.id).text
end