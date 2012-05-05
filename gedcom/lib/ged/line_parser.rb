module GED
  class LineParser
    def initialize(line)
      @line = line
    end

    def parsed
      tokens = @line.scan /\s*([^\s]+)\s*([^\s]+)\s*(.*)/
      level, idortag, value = tokens.first
      values = {
        :level => level.to_i,
        :value => value
      }
      if idortag.match /^@.*@$/
        values[:id] = idortag
      else
        values[:tag] = idortag
      end
      values
    end
  end
end
