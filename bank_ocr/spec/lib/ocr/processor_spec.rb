require 'spec_helper'

describe OCR::Processor do
  let(:example_file) { File.expand_path('../../../example.ocr', __FILE__)}

  subject {OCR::Processor.new(example_file)}

  it "should set the first arg to :input" do
    subject.input.should == example_file
  end

  describe :process do
    it "should chunk every four lines" do
      OCR::LineChunker.should_receive(:new).exactly(4).times
      subject.process
    end

    it "should parse each chunk" do
      mock_parser = OCR::ChunkParser.new(["","","",""])
      OCR::ChunkParser.should_receive(:new).exactly(4).times.
        and_return(mock_parser)
      subject.process
    end

    it "should return an array of parsed numbers" do
      subject.process.should == [
        "457508000",
        "664371495",
        "86110??36",
        "888888888"
      ]
    end
  end
end
