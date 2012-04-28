require 'test_chop.rb'

def chop(a,b)
  return -1 if b.empty?
  if b.length == 1
    return -1 unless b.first == a
    return 0
  end
  mid = b.length / 2
  midpoint = b[mid-1]
  if a <= midpoint
    bottom = b[0,mid]
    return chop(a, bottom)
  else
    upper = b[mid,b.length]
    usearch = chop(a, upper)
    return -1 if usearch == -1
    mid + usearch
  end
end
