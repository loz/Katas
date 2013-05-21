BOOLS = {
  0 => false,
  1 => true
}

def it_has_truth_table(table)
  table = table.to_a
  inputs, outputs = table.shift
  table.each do |ins, outs|
    ins.map! { |v| BOOLS[v] }
    outs.map! { |v| BOOLS[v] }
    ins = Hash[inputs.zip(ins)]
    outs = Hash[outputs.zip(outs)]

    outstr = outs.inspect
    instr = ins.inspect

    result = Result.new

    it "outputs #{outstr} for #{instr}" do
      outs.each do |pin, value|
        subject.attach_output(pin, result, pin)
      end
      ins.each do |pin, value|
        subject.send_input(pin, value)
      end
      outs.each do |pin, value|
        result.state(pin).should == value
      end
    end
  end
end
