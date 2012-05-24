require 'spec_helper'

class Me
  attr_reader :nudges

  def initialize
    @nudges = 0
  end

  def nudge(nudger)
    @nudges += 1
  end

  def nudged?
    @nudges > 0
  end
end

describe Cell do
  let(:me) { Me.new }

  describe "when nudged" do
    context "and the cell is alive" do
      it "nudges back" do
        subject.nudge(me)

        me.should be_nudged
      end
    end

    context "and the cell is dead" do
      before :each do
        subject.live.live.live.live #no interraction should be DEAD
      end

      it "does not nudge back" do
        subject.nudge(me)
        me.should_not be_nudged
      end
    end
  end

  describe :live do

    context "when cell has no neigbors" do
      it "does not live on" do
        subject.live

        subject.nudge(me)
        me.should_not be_nudged
      end
    end

    context "with two live neighbors" do
      before :each do
        @cells = [subject]
        2.times do
          cell = described_class.new
          subject << cell
          @cells << cell
        end

        @cells.each {|c| c.live }
      end

      it "lives" do
        subject.nudge(me)

        me.should be_nudged
      end
    end

    context "with less that two alive neighbors" do
      before :each do
        @cells = [subject]
        alive = described_class.new
        dead  = described_class.new.live
        subject << alive
        subject << dead
        @cells <<  dead << alive

        @cells.each {|c| c.live }
      end

      it "does not survive" do
        subject.nudge(me)

        me.should_not be_nudged
      end
    end
  end
end
