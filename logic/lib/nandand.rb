require 'nand'

class NandAnd
  def initialize
    @nandin = Nand.new
    @nandout = Nand.new
    @nandin.attach_output(:q, @nandout, :a)
    @nandin.attach_output(:q, @nandout, :b)
  end

  def attach_output(pin, target, target_pin)
    @nandout.attach_output(pin, target, target_pin)
  end

  def send_input(pin, value)
    @nandin.send_input(pin, value)
  end
end
