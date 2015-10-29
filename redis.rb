require "redis"
redis = Redis.new
=begin
p redis.class
p redis.set("foo", "bar") 
p redis.get("foo")
=end


=begin
p redis.zadd("#{category}", 50, "ショコラ")
p redis.zadd("#{category}", 40, "フォンダン")
p redis.zadd("#{category}", 30, "フォンデュ")
=end

#p redis.zrange("#{category}", 0, -1, :with_scores => true)
categories = ["チョコレート", "まんじゅう", "せんべい"]

categories.each do | cat |
  puts cat
  p redis.zrevrange("#{cat}", 0, -1, :with_scores => true)
end

p redis.zrevrange("category", 0, -1, :with_scores => true)