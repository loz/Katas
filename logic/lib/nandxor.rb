require 'nand'

class NandXor
  def initialize
    @in = Nand.new
    @mid = {}
    @mid[:a] = Nand.new
    @mid[:b] = Nand.new
    @out = Nand.new

    @in.attach_output(:q, @mid[:a], :b)
    @in.attach_output(:q, @mid[:b], :a)

    @mid[:a].attach_output(:q, @out, :a)
    @mid[:b].attach_output(:q, @out, :b)
  end

  def attach_output(pin, target, target_pin)
    @out.attach_output(pin, target, target_pin)
  end

  def send_input(pin, value)
    @in.send_input(pin, value)
    @mid[pin].send_input(pin, value)
  end
end
