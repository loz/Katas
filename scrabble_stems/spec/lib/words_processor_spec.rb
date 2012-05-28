require 'spec_helper'

describe WordsProcessor do
  context "Given a stream of words" do
    let(:wordstream) do
      words = <<EOF
one
two
three
four
five
six
seven
eight
nine
longer
longest
EOF
      StringIO.new(words)
    end

    subject { described_class.new wordstream }

    describe :select do
      it "returns all the words in the stream of given length" do
        subject.select(3).should == %w{one two six}
        wordstream.rewind
        subject.select(4).should == %w{four five nine}
        wordstream.rewind
        subject.select(5).should == %w{three seven eight}
      end
    end

    describe :stems do
      it "returns a hash of stems for word, with letter for stemming" do
        subject.stems('one').should == {'no' => ['e'], 'en' => ['o'], 'eo' => ['n']}
        subject.stems('two').should == {'tw' => ['o'], 'ow' => ['t'], 'ot' => ['w']}
      end
    end

    describe :all_stems do
      it "given an array of words, returns stems and letters for them" do
        result = subject.all_stems %w{ant any and}
        result['an'].should == [?t, ?y, ?d]
      end
    end
  end
end
