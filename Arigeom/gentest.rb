file = 'generated_test'

T_MAX = 100
N_MAX =  10_000
F_MAX = 100_000

rand = Random.new

tests = rand.rand(T_MAX)

f = File.open(file, 'w')

f.puts tests

tests.times do
  beats = rand.rand(N_MAX)
  f.puts beats
  data = []
  beats.times do
    data << rand.rand(F_MAX)
  end
  data.sort!
  f.puts data.join(' ')
end
