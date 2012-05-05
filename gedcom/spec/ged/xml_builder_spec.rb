require 'spec_helper'

describe GED::XMLBuilder do
  let(:node) { GED::Node.new :tag => :thetag}
  subject { described_class.new node }

  describe :initialized do
    its(:indentation) { should == 0 }
  end

  describe :to_xml do
    it "renders the node" do
      subject.to_xml.should == "<thetag></thetag>"
    end

    context "when there is indentation" do
      subject { described_class.new node, :indentation => 4 }
      it "indents the xml with 2 spaces per indentation level" do
        subject.to_xml.should == "        <thetag></thetag>"
      end
    end

    context "when the node has an id" do
      let(:idnode) { GED::Node.new :tag => :foo,  :id => "@ID1@" }
      subject { described_class.new idnode }

      it "has id as part of xml tag" do
        subject.to_xml.should == %{<foo id="@ID1@"></foo>}
      end
    end

    context "when the node has a value" do
      let(:valnode) { GED::Node.new :tag => :foo,  :value => 'The Value'}
      subject { described_class.new valnode }

      it "has value within the tags" do
        subject.to_xml.should == %{<foo>The Value</foo>}
      end
    end

    context "when the node has children" do
      let(:parentnode) do
        p = GED::Node.new :tag => :parent, :value => 'Parent Value'
        child1 = GED::Node.new :tag => :child
        child2 = child1.dup
        p.children << child1 << child2
        p
      end

      subject { described_class.new parentnode, :indentation => 1 }

      it "renders the node tags on own lines" do
        lines = subject.to_xml.split "\n"
        lines.first.should == "  <parent>"
        lines.last.should == "  </parent>"
      end

      it "renders value on own line, indented one more level" do
        lines = subject.to_xml.split "\n"
        lines[1].should == "    Parent Value"
      end

      it "builds the children and renders them indented one more level" do
        lines = subject.to_xml.split "\n"
        lines[2].should == "    <child></child>"
        lines[3].should == "    <child></child>"
      end
    end
  end
end
