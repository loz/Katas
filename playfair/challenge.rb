require 'playfair'

keytext = "RUBYO" +
          "NAILS" +
          "CDEFG" +
          "HKMPQ" +
          "TVWXZ"

playfair = Playfair.new keytext

message = "Hide the gold in the tree stump"

puts playfair.encode(message)
