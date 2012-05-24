class Cell
  def initialize
    @alive = true
    @neighbors = []
  end

  def <<(neighbor)
    @neighbors << neighbor
  end

  def nudge(nudger)
    nudger.nudge(self) if @alive
  end

  def live
    @nudges = 0
    @neighbors.each {|n| n.nudge(self) }
    @alive = @nudges > 0
    self
  end

end
