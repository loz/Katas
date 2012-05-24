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

  def inhale
    @interacted = []
    if @alive
      @neighbors.each {|n| n.interact(self) }
    end
    self
  end

  def exhale
    if @alive
      @alive = survives?
    else
      @alive = isborn?
    end
    self
  end

  private

  def isborn?
    @interacted.length == 3
  end

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
