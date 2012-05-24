class Cell
  def initialize
    @neighbors = []
  end

  def tick
    @neighbors.each do |n|
      n.impact(self)
    end
    p @impacts
    @alive = !@neighbors.empty?
  end

  def impact(neighbor)
    @impacts ||= 0
    @impacts += 1
  end

  def <<(neighbor)
    @neighbors << neighbor
  end

end
