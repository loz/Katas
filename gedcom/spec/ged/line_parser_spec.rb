require 'spec_helper'

describe GED::LineParser do
  let(:line1) { "0 @ID1@ NODE" }
  let(:line2) { "5 ATTR Some Value For /Attr/" }

  it "returns a hash of parsed attribtes" do
    parser = described_class.new line1
    parser.parsed.should == {
      :level => 0,
      :id => "@ID1@",
      :value => "NODE"
    }

    parser = described_class.new line2
    parser.parsed.should == {
      :level => 5,
      :tag => "ATTR",
      :value => "Some Value For /Attr/"
    }
  end

  it "ignores blank lines" do
    parser = described_class.new ""
    parser.parsed.should be_nil
  end

  context "when no value is present" do
    let(:novalue) { "5 ATTR" }

    it "includes no :value element" do
      parser = described_class.new novalue
      parser.parsed.should_not include :value
    end
  end
end
