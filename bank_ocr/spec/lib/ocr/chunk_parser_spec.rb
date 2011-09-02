require 'spec_helper'

describe OCR::ChunkParser do

  let(:example_chunks) do
    [
      "   " + #a 4
      "|_|" +
      "  |" +
      "   ",
      " _ " + #a 9
      "|_|" +
      " _|" +
      "   ",
      "~~~" + #an unknown char
      "~~~" +
      "~~~" +
      "~~~"
    ]
  end

  subject { OCR::ChunkParser.new(example_chunks)}
  describe :initialize do
    it "should assign the given arg to :chunks" do
      subject.chunks.should == example_chunks
    end
  end

  describe :parsed do
    it "should return a string" do
      subject.parsed.should be_a String
    end

    it "should return a string the same length as the chunk size" do
      subject.parsed.length.should == example_chunks.size
    end

    it "should return 4 for the 4 chunk" do
      subject.parsed[0].should == '4'
    end

    it "should return 9 for the 9 chunk" do
      subject.parsed[1].should == '9'
    end

    it "should return ? for an unknown chunk" do
      subject.parsed[2].should == '?'
    end
  end
end
