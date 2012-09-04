require 'spec_helper'

describe Playfair do
  let(:keytext) do
    "ABCDE" +
    "FGHIK" +
    "LMNOP" +
    "QRSTU" +
    "VWXYZ"
  end

  subject { described_class.new keytext }

  it "encodes as downshifted for digraph in a column" do
    subject.encode("CN").should == "HS"
    subject.encode("MW").should == "RB"
    subject.encode("UK").should == "ZP"
  end

  it "encodes as rightshifted for digraph in a row" do
    subject.encode("AB").should == "BC"
    subject.encode("KG").should == "FH"
    subject.encode("QS").should == "RT"
  end

  it "encodes opposite corners for digraph in rectangle" do
    subject.encode("EV").should == "AZ"
    subject.encode("KM").should == "GP"
    subject.encode("WD").should == "YB"
  end

  it "encodes in digraph pairs" do
    subject.encode("CNABEV").should == "HSBCAZ"
  end

  it "pads digraphs of identical letters with X" do
    subject.encode("TREE").should == subject.encode("TREXE")
    subject.encode("TOO").should_not == subject.encode("TOXO")
  end

  it "pads odd last digraph with a Z" do
    subject.encode("ONE").should == subject.encode("ONEZ")
  end

  it "capitalizes all letters" do
    subject.encode("oNe").should == subject.encode("ONE")
  end

  it "strips out non letters" do
    subject.encode("this is a sentence.").should == subject.encode("THISISASENTENCE")
  end

  describe "for a known key and cyphered text" do
    let(:playfair) do
      "PLAYF" +
      "IREXM" +
      "BCDGH" +
      "KNOQS" +
      "TUVWZ"
    end

    subject { described_class.new playfair }

    let(:decoded) { "Hide the gold in the tree stump" }
    let(:encoded) { "BMODZBXDNABEKUDMUIXMMOUVIF" }

    it "encodes to correctly" do
      subject.encode(decoded).should == encoded
    end
  end
end
