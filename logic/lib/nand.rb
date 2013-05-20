class Nand
  def initialize
    @ins = {}
    @outs = {}
  end

  def attach_output(pin, target, target_pin)
    @outs[pin] ||= []
    @outs[pin] << [target, target_pin]
  end

  def send_input(pin, value)
    @ins[pin] = value
    update_outputs
  end

  private

  def determine_state
    !(@ins[:a] && @ins[:b])
  end

  def update_outputs
    output = determine_state
    @outs[:q].each do |q|
      target, pin = q
      target.send_input(pin, output)
    end
  end
end
