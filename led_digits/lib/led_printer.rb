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

  def initialize()
    @size = 1
  end

  def print_num(n)
    NUMS[n]
  end
end
