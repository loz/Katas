require 'words_processor'

WORDFILE='/usr/share/dict/words'

File.open(WORDFILE) do |f|
  processor = WordsProcessor.new(f)
  words = processor.select(7)
  stems = processor.all_stems(words)
  stems = stems.to_a.map {|stem| [stem[0], stem[1].uniq] }
  stems = stems.to_a.sort do |a,b|
    ak, av = a
    bk, bv = b
    bv.length <=> av.length
  end
  stems.each do |word, joiners|
    puts "%s: %s" % [word, joiners.uniq.sort.join(', ')]
  end
end
