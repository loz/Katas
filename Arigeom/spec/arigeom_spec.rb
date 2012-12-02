require 'spec_helper'

describe Arigeom do
  subject { described_class.new }
  describe :permutations do
    it "returns arrays of possibe sets for current length" do
      result = subject.permutations [1,2,3,4]
      result.to_a.should == [
        [1,2],
        [1,3],
        [1,4],
        [2,3],
        [2,4],
        [3,4],
        [1,2,3],
        [1,2,4],
        [1,3,4],
        [2,3,4],
        [1,2,3,4]
      ]
    end
  end

  describe :geometric_change do
    it "returns difference ratio between numbers" do
      subject.geometric_change([2,4,8,16]).should == [2,2,2]
      subject.geometric_change([2,4,12,66]).should == [2,3,5.5]
    end
  end

  describe :arithmetic_change do
    it "returns the differences between numbers" do
      subject.arithmetic_change([2,4,6,8]).should == [2,2,2]
      subject.arithmetic_change([2,6,12,20]).should == [4,6,8]
    end
  end

  describe :find_geometric do
    it "returns largest combination with equal geometric change" do
      subject.find_geometric([2,4,5,8,11,16]).should == [2, 4, 8, 16]
      subject.find_geometric([1,2,3,4,5]).should == [1,2,4]
      subject.find_geometric([1,3,9,10,19,27,28,81]).should == [1,3,9,27,81]
      subject.find_geometric([1,4,7,10,13,25]).should == [4,10,25]
    end
  end

  describe :find_arithmetic do
    it "returns largest combination with equal arithmetic change" do
      subject.find_arithmetic([2,4,5,8,11,16]).should == [2,5,8,11]
      subject.find_arithmetic([1,2,3,4,5]).should == [1,2,3,4,5]
      subject.find_arithmetic([1,3,9,10,19,27,28,81]).should == [1,10,19,28]
      subject.find_arithmetic([1,4,7,10,13,25]).should == [1,4,7,10,13]
    end
  end
end

