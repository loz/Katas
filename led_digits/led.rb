#!/usr/bin/env ruby -I./lib
require 'led_printer'

def parse_args(args)
  parsed = {}
  switch = nil
  args.each do |a|
    if a.start_with? ?-
      switch = a[1,].to_sym
    elsif switch
      parsed[switch] = a
      switch = nil
    else
      parsed[:num] = a
    end
  end
  parsed
end

args = parse_args($*)

size = args[:s].to_i || 1
printer = LEDPrinter.new(size)
puts printer.print_num(args[:num])
