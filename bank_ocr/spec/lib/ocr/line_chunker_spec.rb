require 'spec_helper'

describe OCR::LineChunker do

  let(:example_lines) do
    [
      "111222333444555666",
      "aaabbbcccdddeeefff",
      "AAABBBCCCDDDEEEFFF",
      "---===---===---==="
    ]
  end

  subject { OCR::LineChunker.new(example_lines)}

  describe :initialize do
    it "should take an argument and assign to :lines" do
      subject.lines.should == example_lines
    end
  end

  describe :to_a do
    it "should return an array" do
      subject.to_a.should be_a Array
    end

    it "should have one element for every 3 characters in the line" do
      subject.to_a.size.should == 6
    end

    it "should return strings for each elements" do
      subject.to_a[0].should be_a String
    end

    it "should vertically split each element" do
      subject.to_a[0].should == "111aaaAAA---"
      subject.to_a[1].should == "222bbbBBB==="
      subject.to_a[2].should == "333cccCCC---"
      subject.to_a[3].should == "444dddDDD==="
      subject.to_a[4].should == "555eeeEEE---"
      subject.to_a[5].should == "666fffFFF==="
    end
  end
end
