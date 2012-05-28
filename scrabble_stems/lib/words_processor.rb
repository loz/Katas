class WordsProcessor
  def initialize(stream)
    @stream = stream
  end

  def select(size)
    selected = []
    @stream.each_line do |line|
      line.chomp!
      selected << line if line.length == size
    end
    selected
  end

  def stems(word)
    stems = {}
    word = word.chars.to_a
    word.length.times do
      letter = word.shift
      stems[word.sort.join] = [letter]
      word.push letter
    end
    #word.chars.to_a.permutation do |letters|
    #  letter = letters.pop
    #  stems[letters.sort.join] = [letter]
    #end
    stems
  end

  def all_stems(words)
    stems = Hash.new([])
    words.each do |word|
      self.stems(word).each do |k, v|
        stems[k] += v
      end
    end
    stems
  end
end
