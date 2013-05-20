require 'nand'
require 'result_reader'

describe Nand do
  let(:result) { Result.new }

  before(:each) { subject.attach_output(:q, result, :a) }

  context "for A false" do
    before { subject.send_input(:a, false) }

    context "B false" do
      before { subject.send_input(:b, false) }

      it "outputs true" do
        result.state(:a).should be_true
      end
    end

    context "B true" do
      before { subject.send_input(:b, true) }

      it "outputs true" do
        result.state(:a).should be_true
      end
    end
  end

  context "for A true" do
    before { subject.send_input(:a, true) }

    context "B false" do
      before { subject.send_input(:b, false) }

      it "outputs true" do
        result.state(:a).should be_true
      end
    end

    context "B true" do
      before { subject.send_input(:b, true) }

      it "outputs false" do
        result.state(:a).should be_false
      end
    end
  end

end
