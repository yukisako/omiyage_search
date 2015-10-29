require_relative "naivebayes.rb"

nb = Training.new

# 学習させる

cat = 'チョコレート'
doc = <<EOS
カカオの種子をいって粉にしたものに、牛乳・バター・砂糖・香料などを加えて練り固めた菓子。飲料もある。チョコ。
チョコレートいろ【チョコレート色】
濃い茶色。
チョコレートケーキ【chocolate cake】
小麦粉・卵・砂糖などで作った生地にココアパウダーやチョコレートを溶かし込んで焼いたスポンジケーキ。ガトーショコラ。
チョコレートパフェ
《(和)chocolate＋parfait(フランス)》アイスクリームにクリーム状チョコレート、生クリーム、果物などを添えた冷菓。
チョコレートパン
《(和)chocolate＋pão(ポルトガル)》中にチョコレートクリームを入れたパン。または、生地にチョコチップやココアを練り込んだパン。チョコパン。
チョコレートフォンデュ
《(和)chocolate＋fondue(フランス)》チョコレートに牛乳や生クリームを加えて、加熱し溶かしたものに、果物・パンなどをからめて食べるデザート。
チョコレートブラウニー【chocolate brownie】
小麦粉・卵・砂糖・チョコレートなどで作った生地に、刻んだ木の実を混ぜて焼いたアメリカ風ケーキ。
EOS
nb.train(doc, cat)


cat = 'せんべい'
doc = <<EOS
干菓子の一。小麦粉に卵・砂糖・水などを加えて溶いて焼いた瓦煎餅の類と、米の粉をこねて薄くのばし、醤油や塩で味つけして焼いた塩煎餅の類とがある。
せんべいじる【煎餅汁】
南部地方の郷土料理の一。鶏肉や野菜などを醤油仕立ての汁で煮込み、南部せんべいを割り入れたもの。
せんべいぶとん【煎餅布団】
入れ綿の少ない、薄くて粗末な布団。
EOS
nb.train(doc, cat)

cat = 'まんじゅう'
doc = <<EOS
小麦粉などの粉をこねた皮であんを包み、蒸すか焼くかしてつくった菓子。そばまんじゅう・酒まんじゅうなど種類が多い。中国で諸葛孔明 (しょかつこうめい) が創始したと伝えられ、日本では、14世紀に宋から渡来した林浄因がつくった奈良饅頭に始まるとされる。
まんじゅうがさ【饅頭笠】
頂が丸くて浅い、まんじゅうの形を思わせるようなかぶり笠。
まんじゅうかなもの【饅頭金物】
釘の頭を隠すために打つ半球形の装飾金物。乳金物(ちかなもの)。
まんじゅうがに【饅頭蟹】
オウギガニ科の一群のカニ。房総半島以南の浅海の岩礁にみられ、甲は横長の楕円形。甲の表面が滑らかなスベスベマンジュウガニは甲幅約5センチ、紫褐色で、有毒。
まんじゅうはだ【饅頭肌】
饅頭のように白くふっくらとした肌。
「きさまの様な―が我等の好物」〈浄・大塔宮〉
EOS
nb.train(doc, cat)

=begin
# カテゴライズする
while(1)
  text = gets.chomp
  if text =~ /終了/
    exit
  end
  puts "#{text} => 推定カテゴリ: #{nb.classifier(text)}"
end
=end