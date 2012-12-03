#!/usr/bin/env ruby

class Arigeom
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
    combination_detect(set) do |combi|
      geometric_change(combi)
    end
  end

  def find_arithmetic(set)
    combination_detect(set) do |combi|
      arithmetic_change(combi)
    end
  end

  private

  def combination_detect(set, &block)
    selected  = []
    set.length.downto(2) do |size|
      set.combination(size).each do |s|
        changes = yield s
        if changes.uniq.size == 1
          return s
        end
      end
    end
    nil
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
