require 'ripper'
require 'sexp_walker'

describe SexpWalker do
  let(:empty) { "" }
  let(:twodef) do
      <<-RUBY
def foo; end
def bar; end
RUBY
  end
  describe "#walk" do
    it "returns empty program" do
      sexp = Ripper.sexp(empty)
      walker = described_class.new(sexp)

      program = walker.walk
      program.should be_a SexpWalker::Program
      program.should have(0).children
    end

    it "returns array of program code" do
      sexp = Ripper.sexp(twodef)
      walker = described_class.new(sexp)

      program = walker.walk
      program.should have(2).children
    end

    it "walks the children of a node" do
      sexp = Ripper.sexp(twodef)
      walker = described_class.new(sexp)

      defs = walker.walk.children

      defs.each do |d|
        d.should be_a SexpWalker::Def
      end
    end

    it "identifies line of elements" do
      sexp = Ripper.sexp(twodef)
      walker = described_class.new(sexp)

      defs = walker.walk.children
      defs[0].line.should == 1
      defs[1].line.should == 2
    end


  end
end
