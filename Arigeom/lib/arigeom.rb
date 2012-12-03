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

  def geometric_acceptor(set)
    acceptor(set) do |cur, last|
      cur.to_f / last.to_f
    end
  end

  def arithmetic_acceptor(set)
    acceptor(set) do |cur, last|
      cur - last
    end
  end

  def find_geometric(set)
    combination_detect(set) do |combi|
      geometric_acceptor(combi)
    end
  end

  def find_arithmetic(set)
    combination_detect(set) do |combi|
      arithmetic_acceptor(combi)
    end
  end

  private

  def combination_detect(set, &block)
    selected  = []
    set.length.downto(2) do |size|
      set.combination(size).each do |s|
        accepted = yield s
        return s if accepted
      end
    end
    nil
  end

  def acceptor(set, &block)
    first = set[0]
    prev = set[1]
    last_change = yield(prev, first)
    set[2..-1].each do |s|
      change = yield(s, prev)
      return unless last_change == change
      prev = s
      last_change = change
    end
    true
  end

  def differ(set, &block)
    prev = set.first
    set[1..-1].map do |s|
      change = yield(s, prev)
      prev = s
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
