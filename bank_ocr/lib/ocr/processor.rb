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

    def calculate_checksum(string)
      return :ill unless string.match /^\d+$/
      if calculate_sum(string).zero?
        :ok
      else
        :err
      end
    end

    def calculate_sum(string)
      total = 0
      chars = string.reverse.chars.to_a
      chars.each_index  do |idx|
        c = chars[idx]
        total += ((idx+1) * c.to_i)
      end
      total % 11
    end
  end
end
