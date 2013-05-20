class Result
  attr_reader :states

  def initialize
    @states = {}
  end

  def send_input(pin, value)
    @states[pin] = value
  end

  def state(pin)
    @states[pin]
  end

end
