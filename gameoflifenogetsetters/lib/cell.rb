class Cell
  def initialize(start_state = :alive)
    @start_state = start_state == :alive
    @neighbors = []
    @interacted = {}
  end

  def <<(neighbor)
    if @neighbors.include? neighbor
      @neighbors << neighbor
    else
      @neighbors << neighbor
      neighbor << self
    end
  end

  def interact(interacter, year = 0)
    unless interacted_with?(interacter, year)
      interacted_with_me(interacter, year)
      interact_with(interacter, year) if alive?(year)
    else
      interacted_with_me(interacter, year)
    end
  end

  def live(year = 0)
    if alive?(year)
      @neighbors.each do |n|
        interact_with(n, year)
      end
    end
    self
  end

  private

  def interaction(year)
    @interacted[year] ||= []
  end

  def alive?(year)
    return @start_state if year == 0
    survived?(year)
  end

  def interacted_with?(neighbor, year)
    interaction(year).include? neighbor
  end

  def interacted_with_me(neighbor, year)
    interaction(year).push neighbor
    interaction(year).uniq!
  end

  def interact_with(neighbor, year)
    neighbor.interact(self, year)
  end

  def survived?(year)
    not overcrowded?(year) and not underpopulated?(year)
  end

  def overcrowded?(year)
    interaction(year-1).length > 3
  end

  def underpopulated?(year)
    interaction(year-1).length < 2
  end
end
