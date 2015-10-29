include Math
require "set"
require "redis"

require_relative "morphological"


def getwords(doc)
  Morphological::split(doc)
end

class Training
  @@redis = Redis.new
  def initialize
    @vocabularies = Set.new
    @wordcount = {}
    @catcount = {}
  end

  def wordcountup(word, cat)
    @wordcount[cat] ||= {}
    @wordcount[cat][word] ||= 0
    @wordcount[cat][word] += 1
    @vocabularies.add(word)
  end

  def catcountup(cat)
    @catcount[cat] ||= 0
    @catcount[cat] += 1
  end

  def train(doc, cat)
    word = getwords(doc)
    word.each do |w|
      wordcountup(w, cat)
    end
    catcountup(cat)
    p @wordcount[cat]
#    p @vocabularies
    p @catcount
    @wordcount[cat].each do |name, score|
      p "#{name}  #{score}  "
      puts @@redis.zadd("#{cat}", score, "#{name}")
    end
    @catcount.each do |name, score|
      p "#{name}  #{score}"
      puts @@redis.zadd("category", score,"#{name}")
    end
  end
end

class Categorize
  @@redis = Redis.new
  def initialize
    cat = "category"
    @vocabcount = @@redis.zrevrange("#{cat}", 0, -1, :with_scores => true).size
    p @catcount = @@redis.zrevrange("#{cat}", 0, -1, :with_scores => true)
    p @catcount = Hash[*@catcount.flatten]
    @wordcount = {}
    @catcount.each do |key, values|
      @hoge = @@redis.zrevrange("#{key}", 0, -1, :with_scores => true)
      @wordcount[key] = Hash[*@hoge.flatten]
    end
    @vocabcount = @catcount.size
    #puts @wordcount
  end

  #カテゴライズするメソッド
  def classifier(doc)
    best = nil
    maxint = 1 << (1.size * 8 - 2) - 1
    max = -maxint
    word = getwords(doc)
    #@catcount.keys
    for cat in @catcount.keys
      prob = score(word, cat)
      if prob > max
        max = prob
        best = cat
      end
    end
    best
  end

  def score(word, cat)
    score = Math.log(priorprob(cat))
    word.each do |w|
      score += Math.log(wordprob(w, cat))
    end
    print "カテゴリ#{cat} のスコアは "
    p score
  end

  def priorprob(cat)
    prob = @catcount[cat] / @catcount.values.inject(:+).to_f
    p @wordcount[cat].values.inject(:+)
    prob
  end

  def incategory(word, cat)
    #あるカテゴリの中に単語が登場した回数を返す
    if @wordcount[cat].has_key?(word)
      @wordcount[cat][word].to_f
      return @wordcount[cat][word].to_f
    end
    return 0.0
    # @wordcount[cat].key(word).nil? ? 0.0 : @wordcount[cat][word].to_f
  end

  def wordprob(word, cat)
    # P(word|cat)が生起する確率を求める
    prob = (incategory(word, cat) + 1.0) / (@wordcount[cat].values.inject(:+) + @vocabcount * 1.0)
    prob
  end
end
