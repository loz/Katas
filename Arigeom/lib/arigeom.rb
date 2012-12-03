#!/usr/bin/env ruby

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
    combination_select(set) do |combi|
      geometric_change(combi)
    end.last
  end

  def find_arithmetic(set)
    combination_select(set) do |combi|
      arithmetic_change(combi)
    end.last
  end

  private

  def combination_select(set, &block)
    selected  = []
    (2..set.length).each do |size|
      set.combination(size).each do |s|
        changes = yield s
        if changes.uniq.size == 1
          selected << s
        end
      end
    end
    selected
  end

  def differ(set, &block)
    last = set.first
    set[1..-1].map do |s|
      change = yield(s, last)
      last = s
      change
    end
  end
end

if __FILE__ == $0
  finder = Arigeom.new
  tests = readline.chomp.to_i
  tests.times do
    _ = readline
    set = readline.split(' ').map &:to_i
    puts finder.find_arithmetic(set).join(" ")
    puts finder.find_geometric(set).join(" ")
  end
end
