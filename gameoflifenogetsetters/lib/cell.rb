class Cell
  def initialize
    @alive = true
    @neighbors = []
    @interacted = []
  end

  def <<(neighbor)
    @neighbors << neighbor
  end

  def interact(interacter)
    unless @interacted.include? interacter
      @interacted << interacter
      interacter.interact(self) if @alive
    end
  end

  def live
    if @alive
      @interacted = []
      @neighbors.each {|n| n.interact(self) }
      @alive = survives?
    end
    self
  end

  private

  def survives?
    not overcrowded? and not underpopulated?
  end

  def overcrowded?
    @interacted.length > 3
  end

  def underpopulated?
    @interacted.length < 2
  end
end
