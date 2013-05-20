require 'nandor'
require 'result_reader'

describe NandOr do
  let(:result) { Result.new }
  before(:each) { subject.attach_output(:q, result, :a) }

  context "for A false" do
    before { subject.send_input(:a, false) }

    context "for B false" do
      before { subject.send_input(:b, false) }

      it "outputs false" do
        result.state(:a).should be_false
      end
    end

    context "for B true" do
      before { subject.send_input(:b, true) }

      it "outputs false" do
        result.state(:a).should be_true
      end
    end

  end

  context "for A true" do
    before { subject.send_input(:a, true) }

    context "for B false" do
      before { subject.send_input(:b, false) }

      it "outputs false" do
        result.state(:a).should be_true
      end
    end

    context "for B true" do
      before { subject.send_input(:b, true) }

      it "outputs true" do
        result.state(:a).should be_true
      end
    end
  end
end
