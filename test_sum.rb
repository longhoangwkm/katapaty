require_relative './sum'

def test_sum
  raise 'sum(1, 2) failed' unless sum(1, 2) == 3
  raise 'sum(-1, 1) failed' unless sum(-1, 1) == 0
  raise 'sum(0, 0) failed' unless sum(0, 0) == 0
  raise 'sum(100, 200) failed' unless sum(100, 200) == 300
  puts 'All tests passed.'
end

test_sum
