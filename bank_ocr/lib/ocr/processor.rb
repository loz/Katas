module OCR
  class Processor
    attr_reader :input

    def initialize(input_file)
      @input = input_file
    end

    def process
      processed = []
      File.open(@input) do |f|
        lines = []
        until f.eof?
          lines << f.readline
          if lines.length == 4
            processed << OCR::ChunkParser.new(OCR::LineChunker.new(lines).to_a).parsed
            lines = []
          end
        end
      end
      processed
    end
  end
end
