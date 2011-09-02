module OCR

  #Chunks a line into digits
  class LineChunker
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def to_a
      scanned = lines.map {|l| l.scan(/.{3}/)}
      first = scanned.rotate!.pop
      first.zip(*scanned).map &:join
    end
  end
end
