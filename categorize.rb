require_relative "naivebayes.rb"

nb = Categorize.new

# カテゴライズする
while(1)
  text = gets.chomp
  if text =~ /終了/
    exit
  end
  puts "#{text} => 推定カテゴリ: #{nb.classifier(text)}"
end