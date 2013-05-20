require 'nandnot'
require 'result_reader'

describe NandNot do
  let(:result) { Result.new }
  before(:each) { subject.attach_output(:q, result, :a) }

  context "for A false" do
    before { subject.send_input(:a, false) }

    it "outputs true" do
      result.state(:a).should be_true
    end
  end

  context "for A true" do
    before { subject.send_input(:a, true) }

    it "outputs true" do
      result.state(:a).should be_false
    end
  end
end
