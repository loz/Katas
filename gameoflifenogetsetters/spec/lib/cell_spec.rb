require 'spec_helper'

class Me
  attr_reader :interacts

  def initialize
    @interactions = 0
  end

  def interact(interacter)
    @interactions += 1
  end

  def interacted?
    @interactions > 0
  end
end

describe Cell do
  let(:me) { Me.new }

  describe "when interacted with" do
    context "and the cell is alive" do
      it "interacts back" do
        subject.interact(me)

        me.should be_interacted
      end
    end

    context "and the cell is dead" do
      before :each do
        subject.inhale.exhale.inhale.exhale #no interraction should be DEAD
      end

      it "does not interact back" do
        subject.interact(me)
        me.should_not be_interacted
      end
    end
  end

  describe :live do

    context "when cell has no neigbors" do
      it "does not live on" do
        subject.inhale.exhale

        subject.interact(me)
        me.should_not be_interacted
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

        @cells.each {|c| c.inhale}
        @cells.each {|c| c.exhale }
      end

      it "lives" do
        subject.interact(me)

        me.should be_interacted
      end
    end

    context "with less that two alive neighbors" do
      before :each do
        @cells = [subject]
        alive = described_class.new
        dead  = described_class.new.inhale.exhale
        subject << alive
        subject << dead
        @cells <<  dead << alive

        @cells.each {|c| c.inhale }
        @cells.each {|c| c.exhale }
      end

      it "dies from under-population" do
        subject.interact(me)

        me.should_not be_interacted
      end
    end

    context "when more than 3 live neighbors" do
      before :each do
        @cells = [subject]
        4.times do
          cell = described_class.new
          subject << cell
          @cells << cell
        end

        @cells.each {|c| c.inhale }
        @cells.each {|c| c.exhale }
      end

      it "dies from overcrowding" do
        subject.interact(me)

        me.should_not be_interacted
      end
    end

    context "when cell is currently dead" do
      before :each do
        subject.inhale.exhale.inhale.exhale
      end

      context "and it has only 2 live neighbors" do
        before :each do
          @cells = [subject]
          2.times do
            cell = described_class.new
            subject << cell
            @cells << cell
          end

          @cells.each {|c| c.inhale }
          @cells.each {|c| c.exhale }
        end

        it "should stay dead" do
          subject.interact(me)
          me.should_not be_interacted
        end
      end

      context "and it has 3 live neighbors" do
        before :each do
          @cells = [subject]
          3.times do
            cell = described_class.new
            subject << cell
            @cells << cell
          end

          @cells.each {|c| c.inhale }
          @cells.each {|c| c.exhale }
        end

        it "becomes alive by reproduction" do
          subject.interact(me)

          me.should be_interacted
        end
      end
    end
  end
end
