require 'spec_helper'

describe GED::XMLBuilder do
  describe :initialized do
    its(:indentation) { should == 0 }
  end

  describe :to_xml do
    it "renders the node" do
      subject.to_xml.should == "<thetag></thetag>"
    end
    context "when there is indentation" do
      subject { described_class.new :indentation => 4 }
      it "indents the xml with 2 spaces per indentation level" do
        subject.to_xml.should == "        <thetag></thetag>"
      end
    end
  end
end
