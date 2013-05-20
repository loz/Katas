require 'nand'

class NandNot
  def initialize
    @nand = Nand.new
  end

  def attach_output(pin, target, target_pin)
    @nand.attach_output(pin, target, target_pin)
  end

  def send_input(pin, value)
    @nand.send_input(:a, value)
    @nand.send_input(:b, value)
  end
end
