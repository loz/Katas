require 'nand'

class NandNor
  def initialize
    @ins = {}
    @ins[:a] = Nand.new
    @ins[:b] = Nand.new
    @out = Nand.new
    @neg = Nand.new

    @ins[:a].attach_output(:q, @out, :a)
    @ins[:b].attach_output(:q, @out, :b)

    @out.attach_output(:q, @neg, :a)
    @out.attach_output(:q, @neg, :b)
  end

  def attach_output(pin, target, target_pin)
    @neg.attach_output(pin, target, target_pin)
  end

  def send_input(pin, value)
    @ins[pin].send_input(:a, value)
    @ins[pin].send_input(:b, value)
  end
end
