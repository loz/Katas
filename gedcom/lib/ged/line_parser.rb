module GED
  class LineParser
    def initialize(line)
      @line = line
    end

    def parsed
      return if @line.empty?
      tokens = @line.scan /\s*([^\s]+)\s*([^\s]+)\s*(.*)/
      level, idortag, value = tokens.first
      values = {
        :level => level.to_i,
      }
      values[:value] = value unless value.empty?
      if idortag.match /^@.*@$/
        values[:id] = idortag
      else
        values[:tag] = idortag
      end
      values
    end
  end
end
