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
    join_digits(digits(n).map {|d| scale_digit(NUMS[d]) })
  end

  private

  def scale_digit(digit)
    return digit if @size <= 1
    top, mid, bottom = digit.split("\n").map {|r| scale_horizontal(r) }
    rows = [top]
    (@size-1).times { rows << mid.gsub('_', ' ') }
    rows << mid
    (@size-1).times { rows << bottom.gsub('_', ' ') }
    rows << bottom
    rows.join("\n")
  end

  def scale_horizontal(row)
    [row[0], row[1] * @size, row[2]].join
  end

  def join_digits(digits)
    digits.map {|d| d.split "\n" }.transpose.map {|l| l.join(' ')}.join("\n")
  end

  def digits(n)
    n.to_s.each_char.map {|c| c.to_i }
  end
end
