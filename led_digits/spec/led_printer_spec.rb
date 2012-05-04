require 'spec_helper'

describe LEDPrinter do
  describe :default do
    its(:size) { should == 1 }

    describe :print_num do
      it "prints small LED 0 for 0" do
        subject.print_num(0).should == " _ \n" \
                                       "| |\n" \
                                       "|_|"
      end

      it "prints small LED 1 for 1" do
        subject.print_num(1).should == "   \n" \
                                       "  |\n" \
                                       "  |"
      end

      it "prints small LED 2 for 2" do
        subject.print_num(2).should == " _ \n" \
                                       " _|\n" \
                                       "|_ "
      end

      it "prints small LED 3 for 3" do
        subject.print_num(3).should == " _ \n" \
                                       " _|\n" \
                                       " _|"
      end

      it "prints small LED 4 for 4" do
        subject.print_num(4).should == "   \n" \
                                       "|_|\n" \
                                       "  |"
      end

      it "prints small LED 5 for 5" do
        subject.print_num(5).should == " _ \n" \
                                       "|_ \n" \
                                       " _|"
      end

      it "prints small LED 6 for 6" do
        subject.print_num(6).should == " _ \n" \
                                       "|_ \n" \
                                       "|_|"
      end

      it "prints small LED 7 for 7" do
        subject.print_num(7).should == " _ \n" \
                                       "  |\n" \
                                       "  |"
      end

      it "prints small LED 8 for 8" do
        subject.print_num(8).should == " _ \n" \
                                       "|_|\n" \
                                       "|_|"
      end

      it "prints small LED 9 for 9" do
        subject.print_num(9).should == " _ \n" \
                                       "|_|\n" \
                                       " _|"
      end

      it "prints multiple digit numbers in one line" do
        subject.print_num(123).should == "    _  _ \n" \
                                         "  | _| _|\n" \
                                         "  ||_  _|"
        subject.print_num(456).should == "    _  _ \n" \
                                         "|_||_ |_ \n" \
                                         "  | _||_|"
      end
    end
  end

  describe "When size is two" do
    subject { described_class.new 2}

    its(:size) { should == 2 }

    it "prints digits twice the size" do
      subject.print_num(8).should == " __ \n" \
                                     "|  |\n" \
                                     "|__|\n" \
                                     "|  |\n" \
                                     "|__|"
    end
  end
end
