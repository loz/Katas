require 'playfair'

SOURCE = File.expand_path('../../dickens-christmas-125.txt', __FILE__)

content = File.read(SOURCE)

keytext = "CHARL" +
          "SEDIK" +
          "NBFGM" +
          "OPQTU" +
          "VWXYZ"

playfair = Playfair.new keytext

outfile = "dickens.encoded.txt"

File.open(outfile, "w") do |f|
  content.each_line do |line|
    f.puts playfair.encode(line)
  end
end
