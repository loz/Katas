require 'nand'

class NandOr
  def initialize
    @ins = {}
    @ins[:a] = Nand.new
    @ins[:b] = Nand.new
    @nandout = Nand.new

    @ins[:a].attach_output(:q, @nandout, :a)
    @ins[:b].attach_output(:q, @nandout, :b)
  end


  def attach_output(pin, target, target_pin)
    @nandout.attach_output(pin, target, target_pin)
  end

  def send_input(pin, value)
    @ins[pin].send_input(:a, value)
    @ins[pin].send_input(:b, value)
  end
end
