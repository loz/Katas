require 'spec_helper'

class GED::Tokenizer
  #For Tests
  attr_writer :level
end

describe GED::Tokenizer do
  describe :initialized do
    it "has a root node with no children" do
      subject.tree.children.should be_empty
      subject.tree.tag.should == :gedcom
    end

    it "has root node as current node" do
      subject.current_node.should == subject.tree
    end
    its(:level) { should == 0 }
  end

  describe :process do
    it "ignores nil values" do
      subject.process(nil).should be_nil
    end

    describe "When new line level is same as current level" do
      let(:line) { {:level => 1, :tag => "ATAG", :value => 'The value'} }
      let(:line2) { {:level => 1, :tag => "OTHR", :value => 'Another Value'} }
      before(:each) { subject.level = 1 }

      it "adds node as sibiling" do
        new_node = subject.process line

        subject.current_node.children.last.should == new_node
      end

      it "uses parsed :tag as lowercase symbol for the node tag" do
        new_node = subject.process line2

        new_node.tag.should == :othr
        new_node.value.should == 'Another Value'
      end

      context "when parsed line has id not tag" do
        let(:idline) { {:level => 1, :id => "@ID1@", :value => "ANODE"} }
        before :each do
          @new_node = subject.process idline
        end

        it "sets the id of the new node to parsed id" do
          @new_node.id.should == "@ID1@"
        end

        it "uses the value as the tag for the node" do
          @new_node.tag.should == :anode
          @new_node.value.should be_nil
        end
      end
    end

    describe "When new line level is higher" do
      let(:line) { {:level => 0, :id => "@ID1@", :value => "ANODE"} }
      let(:nextline) { {:level => 1, :tag => "ATAG", :value => "Child Value"} }
      before :each do
        @last_node = subject.process line
        @new_node = subject.process nextline
      end

      it "adds the node as child of previous node" do
        @last_node.children.should include @new_node
      end

      it "sets current node to the previous node" do
        subject.current_node.should == @last_node
      end

      it "sets the level to the new level" do
        subject.level.should == 1
      end
    end

    describe "When new line level is lower" do
      let(:line) { {:level => 0, :id => "@ID1@", :value => "ANODE"} }
      let(:nextline) { {:level => 1, :tag => "ATAG", :value => "Child Value"} }
      let(:anotherline) do
        {:level => 2, :tag => "ATAG", :value => "GrandChild Value"}
      end
      let(:lowerline) { {:level => 0, :id => "@ID2@", :value => "ANTHR"} }

      before :each do
        @root = subject.current_node
        @last_node = subject.process line
        subject.process nextline
        subject.process anotherline
        @new_node = subject.process lowerline
      end

      it "adds the new node to current node's parent" do
        @root.children.last.should == @new_node
      end

      it "sets the current node to the parent node again" do
        subject.current_node.should == @root
      end

      it "sets the level to the new level again" do
        subject.level.should == 0
      end
    end
  end
end
