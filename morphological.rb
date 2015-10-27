require "nokogiri"
require 'open-uri'


APPID = 'dj0zaiZpPUljbG9Ja3VNYlVlSiZzPWNvbnN1bWVyc2VjcmV0Jng9Yjg-'
REQUEST_URL = "http://jlp.yahooapis.jp/MAService/V1/parse"

module Morphological
  extend self
  def split(sentence, appid=APPID, results="ma", filter="1|2|3|4|5|9|10")
    params = "?appid=#{APPID}&results=#{results}&filter=#{URI.encode(filter)}&sentence=#{URI.encode(sentence)}"
    doc = Nokogiri::HTML(open(REQUEST_URL + params))
    surfaces = doc.xpath('//word/surface').map{|i| i.text} rescue nil
    p surfaces
  end
end