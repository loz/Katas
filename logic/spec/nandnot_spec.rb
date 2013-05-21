require 'nandnot'
require 'spec_helper'

describe NandNot do
  it_has_truth_table [:a] => [:q],
    [0] => [1],
    [1] => [0]
end
