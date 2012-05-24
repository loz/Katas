require 'spec_helper'

class InspectableCell < Cell
  def is_alive?
    @alive
  end
end

describe Cell do
  subject { InspectableCell.new }
  describe :tick do
    context "with no neigbours" do
      before :each do
        subject.tick
      end

      it "dies" do
        subject.is_alive?.should be_false
      end
    end

    context "with two live neighbours" do
      before :each do
        2.times { subject << described_class.new }
        subject.tick
      end

      it "lives" do
        subject.is_alive?.should be_true
      end
    end

    context "with less than two *live* neighbors" do
      before :each do
        live = described_class.new
        dead = described_class.new
        dead.tick
        subject << live << dead
        subject.tick
      end

      it "dies" do
        subject.is_alive?.should be_false
      end
    end
  end
end
