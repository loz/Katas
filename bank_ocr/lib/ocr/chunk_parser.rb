module OCR
  # Given an array of chunked (see Line Chunker)
  # parse them for numbers
  class ChunkParser
    attr_reader :chunks

    #Chunks known string of 0-9, so we
    # know what they look like
    FINGER_PRINTS = LineChunker.new([
    " _     _  _     _  _  _  _  _ ",
    "| |  | _| _||_||_ |_   ||_||_|",
    "|_|  ||_  _|  | _||_|  ||_| _|",
    "                              "
    ]).to_a

    def initialize(chunks)
      @chunks = chunks
    end

    def parsed
      chunks.map {|c| FINGER_PRINTS.index(c) || "?" }.join
    end
  end
end
