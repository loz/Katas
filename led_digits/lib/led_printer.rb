class LEDPrinter
  attr_accessor :size

  NUMS = [
    " _ \n" \
    "| |\n" \
    "|_|",
    "   \n" \
    "  |\n" \
    "  |",
    " _ \n" \
    " _|\n" \
    "|_ ",
    " _ \n" \
    " _|\n" \
    " _|",
    "   \n" \
    "|_|\n" \
    "  |",
    " _ \n" \
    "|_ \n" \
    " _|",
    " _ \n" \
    "|_ \n" \
    "|_|",
    " _ \n" \
    "  |\n" \
    "  |",
    " _ \n" \
    "|_|\n" \
    "|_|",
    " _ \n" \
    "|_|\n" \
    " _|",
  ]

  def initialize(size = 1)
    @size = size
  end

  def print_num(n)
    join_digits(digits(n).map {|d| NUMS[d] })
  end

  private

  def join_digits(digits)
    digits.map {|d| d.split "\n" }.transpose.map {|l| l.join('')}.join("\n")
  end

  def digits(n)
    n.to_s.each_char.map {|c| c.to_i }
  end
end
