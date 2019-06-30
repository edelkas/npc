dir = "/home/eduardo/.steam/steam/steamapps/common/N++/NPP/Palettes/vasquez"
files = Dir.entries(dir).reject{|s| s=="."||s==".."}.sort
files = files.map{ |f|
  {name: f, file: File.binread(dir + "/" + f)}
}
files.each{ |f|
  print(f[:name] + "\n")
  width = f[:file][12..13].reverse.unpack('H*')[0].to_i(16)
  colors = width / 64
  initial = 18 + 4 * 32 * width + 4 * 32
  step = 4 * 64
  (0..colors - 1).each{ |i|
    color_code = f[:file][initial + step * i .. initial + step * i + 3]
    color = color_code[0..2].reverse.unpack('H*')[0].upcase
    print(color + "\n")
  }
  print("\n")
}



