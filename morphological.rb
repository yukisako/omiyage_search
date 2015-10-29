require "nokogiri"
require 'open-uri'
require 'natto'
require 'MeCab'

#yahooから取得したAPPIDを入れる(mecabを使うなら不要)
APPID = ''
REQUEST_URL = "http://jlp.yahooapis.jp/MAService/V1/parse"

module Morphological
  extend self
  def split_yahoo(sentence, appid=APPID, results="ma", filter="1|2|3|4|5|9|10")
    params = "?appid=#{APPID}&results=#{results}&filter=#{URI.encode(filter)}&sentence=#{URI.encode(sentence)}"
    doc = Nokogiri::HTML(open(REQUEST_URL + params))
    surfaces = doc.xpath('//word/surface').map{|i| i.text} rescue nil
    p surfaces
  end

  def split(sentence)
    mecab = MeCab::Tagger.new
    node = mecab.parseToNode(sentence)
    word_array = []
     
    begin
        node = node.next
        if /^名詞/ =~ node.feature.force_encoding("UTF-8")
            word_array << node.surface.force_encoding("UTF-8")
        end
        if /^形容詞/ =~ node.feature.force_encoding("UTF-8")
            word_array << node.surface.force_encoding("UTF-8")
        end
        if /^動詞/ =~ node.feature.force_encoding("UTF-8")
          word_array << node.surface.force_encoding("UTF-8")
        end
    end until node.next.feature.include?("BOS/EOS")
     
    p word_array
  end
end

