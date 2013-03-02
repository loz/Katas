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
  describe "#to_hash" do
    it "returns empty program" do
      sexp = Ripper.sexp(empty)
      walker = described_class.new(sexp)

      walker.to_hash.should== {:program => []}
    end

    it "returns array of program code" do
      sexp = Ripper.sexp(twodef)
      walker = described_class.new(sexp)

      walker.to_hash[:program].should have(2).items
    end

    it "hashes the children of a node" do
      sexp = Ripper.sexp(twodef)
      walker = described_class.new(sexp)

      defs = walker.to_hash[:program]
      defs[0][:def].should be
      defs[1][:def].should be
    end

  end
end
