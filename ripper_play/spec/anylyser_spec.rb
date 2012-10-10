require 'spec_helper'

describe Analyser do
  let(:ruby) do
    <<RUBY
class Foo; end
class Bar
  def baz; end
  def buz; end
end
RUBY
  end

  subject { described_class.new ruby }

  describe :stats do
    it "includes the number of classes defined" do
      subject.stats[:classes].should == 2
    end
  end

  describe :each_part do
    it "itterates over each part of given :part in current scope" do
      klasses = []
      subject.each_part(:class) {|part| klasses << part.name }
      klasses.should == ["Foo", "Bar"]
    end

    it "yields analysed parts" do
      bar = subject.each_part(:class).detect {|part| part.name == "Bar"}

      bar.stats[:methods].should == 2
      methods = bar.each_part(:method).map &:name
      methods.should == ["baz", "buz"]
    end
  end
end
