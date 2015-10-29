require_relative "naivebayes.rb"

nb = Training.new

cat = ["チョコレート", "せんべい", "まんじゅう"]

cat = 'チョコレート'
doc = File.open('./training_data/チョコレート.txt').read
nb.train(doc, cat)

cat = 'せんべい'
doc = File.open('./training_data/せんべい.txt').read
nb.train(doc, cat)

cat = 'まんじゅう'
doc = File.open('./training_data/まんじゅう.txt').read
nb.train(doc, cat)