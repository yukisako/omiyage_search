require_relative "naivebayes.rb"

nb = Training.new

category = ["チョコレート", "せんべい", "まんじゅう", "ゆるキャラ物", "キーホルダー","Tシャツ"]
#category = ["チョコレート", "せんべい", "まんじゅう", "ゆるキャラ物", "キーホルダー","Tシャツ", "置物", "クッキー", "絵葉書", "ケーキ", "タオル", "アクセサリ","アルコール"]

category.each do |cat|
  doc = File.open("./training_data/#{cat}.txt").read
  nb.train(doc, cat)
end