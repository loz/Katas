class Arigeom
  def permutations(set)
    options = []
    (2..set.length).each do |size|
      o = set.combination(size).to_a
      options += o
    end
    options
  end

  def geometric_change(set)
    differ(set) do |cur, last|
      cur.to_f / last.to_f
    end
  end

  def arithmetic_change(set)
    differ(set) do |cur, last|
      cur - last
    end
  end

  def find_geometric(set)
    options = permutations(set)
    changes = options.map { |o| {set: o, change: geometric_change(o)} }
    sets = changes.select {|o| o[:change].uniq.length == 1 }
    sets = sets.map { |o| o[:set] }
    sets.last
  end

  def find_arithmetic(set)
    options = permutations(set)
    changes = options.map { |o| {set: o, change: arithmetic_change(o)} }
    sets = changes.select {|o| o[:change].uniq.length == 1 }
    sets = sets.map { |o| o[:set] }
    sets.last
  end

  private

  def differ(set, &block)
    options = set.dup
    last = options.shift
    options.map do |s|
      change = yield(s, last)
      last = s
      change
    end
  end
end
