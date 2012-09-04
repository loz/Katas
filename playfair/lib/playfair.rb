class Playfair
  DigraphChar = Struct.new(:char, :x, :y)

  def initialize(keytext)
    @key = keytext.scan /\w{5}/
  end

  def encode(message)
    message = sanitize_message(message)
    digraphs = split_message(message)
    digraphs.map {|d| encode_digraph(d) }.join""
  end

  private

  def sanitize_message(message)
    message = message.upcase.gsub(/[^A-Z]/, '')
    message = replace_equivelants(message)
    pad_message(message)
  end

  def replace_equivelants(message)
    message.gsub('J', 'I')
  end

  def pad_message(message)
    message = pad_pairs(message)
    if message.length.odd?
      message + "Z"
    else
      message
    end
  end

  def pad_pairs(message)
    last = message.length.odd? ? message[-1] : ""
    message.scan(/\w{2}/).map do |d|
      if d[0] == d[1]
        "#{d[0]}X#{d[0]}"
      else
        d
      end
    end.join + last
  end

  def split_message(message)
    message.scan(/\w{2}/).map {|d| analyse_digraph(d) }
  end

  def analyse_digraph(chars)
    chars.each_char.map do |c|
      char = DigraphChar.new :char => c
      char.x, char.y = charpos(c)
      char
    end
  end

  def encode_digraph(digraph)
    if horizontal?(digraph)
      encode_horizontal(digraph)
    elsif vertical?(digraph)
      encode_vertically(digraph)
    else
      encode_rectangle(digraph)
    end
  #rescue
  #  puts "Unable to Encode '#{digraph}'"
  end

  def horizontal?(digraph)
    digraph[0].y == digraph[1].y
  end

  def vertical?(digraph)
    digraph[0].x == digraph[1].x
  end

  def encode_horizontal(digraph)
    digraph.map do |char|
      e_x = if char.x == 4
        0
      else
        char.x + 1
      end
      @key[char.y][e_x]
    end.join
  end

  def encode_vertically(digraph)
    digraph.map do |char|
      e_y = if char.y == 4
        0
      else
        char.y + 1
      end
      @key[e_y][char.x]
    end.join
  end

  def encode_rectangle(digraph)
    a, b = digraph
    chars = @key[a.y][b.x]
    chars << @key[b.y][a.x]
  end

  def charpos(char)
    x, y = 0, 0
    @key.each do |row|
      if row.include?(char)
        x = row.index(char)
        break
      end
      y += 1
    end
    [x, y]
  end
end
