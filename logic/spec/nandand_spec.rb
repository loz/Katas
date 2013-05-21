require 'nandand'
require 'spec_helper'

describe NandAnd do
  it_has_truth_table [:a, :b] => [:q],
    [0, 0] => [0],
    [1, 0] => [0],
    [0, 1] => [0],
    [1, 1] => [1]
end
