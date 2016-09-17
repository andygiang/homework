class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map{|word|word.chomp}
  end
  def similar?(word1,word2)
    return false if (word1.length != word2.length || word1 == word2)
    different = 0
    for i in (0...word1.length)
      if word1[i] != word2[i] && different > 0
        return false
      elsif word1[i]!= word2[i]
        different +=1
      else
        next
      end
    end
    return true
  end
  def adjacent_words(word)
    @dictionary.select {|test_word| similar?(word,test_word)}
  end
  def run(source,target)
    @current_words = source
    @all_seen_words = source

    until  @current_words.empty?
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adjacent_word|
          next if @all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words << adjacent_word
        end
      end
    end
    print new_current_words
    @current_words = new_current_words
  end
end

a = WordChainer.new("dictionary.txt")

p a.adjacent_words("dog")
