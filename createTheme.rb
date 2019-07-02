require 'tk'
require_relative 'colors.rb'

$root = TkRoot.new('title' => 'N++ Palette Creator')
TkButton.new($root, 'text' => 'Load palette', 'command' => (proc{ parse_palette })).pack('side' => 'top', 'fill' => 'x', 'expand' => 1)

class ColorSelection < TkFrame

  @@blocks = []

  attr_accessor :object, :button
  def initialize(frame, object, row, column)
    super(frame)
    @object = object
    @button = TkButton.new(self){
      text ''
      width 2
      height 2
      background ('#' + object[:color])
    }
    @button.command(proc{ change_color })
    @button.pack('side' => 'left')
    @text = TkLabel.new(self, 'anchor' => 'w', 'text' => object[:text]).pack('side' => 'left')
    self.grid('row' => row, 'column' => column, 'sticky' => 'w')
    @@blocks << self
  end

  def self.update_colors
    @@blocks.each{ |b|
      b.button.configure('background', '#' + b.object[:color])
    }
  end

  def change_color
    color = Tk.chooseColor('initialcolor' => @button.cget('background'))
    if color.is_a?(String) && color.size > 2
      @button.configure('background', color)
      @object[:color] = color[1..-1]
    end
  end
end

notebook = Tk::Tile::Notebook.new($root).pack('side' => 'top', 'fill' => 'both', 'expand' => 1)
tabs = {
  'Objects' => TkFrame.new(notebook),
  'Menu' => TkFrame.new(notebook),
  'Effects' => TkFrame.new(notebook),
  'Editor' => TkFrame.new(notebook),
  'Timebar' => TkFrame.new(notebook),
  'Others' => TkFrame.new(notebook)
}
tabs.each do |tab, frame|
  notebook.add(frame, 'text' => tab)
end
$objects['background'].each_with_index{ |o, i| ColorSelection.new(tabs['Objects'], o, i, 0) }

def create_file(name: "themeImage", colors: ["4D564F", "87948C"], folder: Dir.pwd)
  Dir.chdir(folder) do
    File.open(name + ".tga", "w") do |f|
      header = {}
      header["id_length"] = "\x00" # none
      header["colormap_type"] = "\x00" # none
      header["image_type"] = "\x0A" # run-length encoded true-color image
      header["colormap_spec"] = "\x00\x00\x00\x00\x00" # none
      header["origin"] = "\x00\x00\x00\x00" # x and y coordinates
      header["width"] = [(64 * colors.size).to_s(16).rjust(4, "0")].pack('H*').reverse # calculate width
      header["height"] = "\x40\x00" # height is always 64 pixels
      header["pixel_depth"] = "\x18" # 24 bit
      header["alpha_info"] = "\x00" # none
      image = header.values.join
      (0..63).each do |row|
        colors.each do |color|
          # \xBF: First bit set to 1 indicates RLE data, last 7 bits indicate the count, in this case, 64.
          image << "\xBF".force_encoding('ASCII-8BIT') + [color.scan(/../).reverse.join].pack('H*')
        end
      end
      f.write(image)
    end
  end
end

def create_palette
  Dir.mkdir($palette_name.get()) unless File.exists?($palette_name.get())
  $objects.each{ |file, colors|
    create_file(folder: $palette_name.get(), name: file, colors: colors.map{ |o| o[:color] })
  }
end

def parse_file(name: "themeImage", folder: Dir.pwd)
  colors = []
  Dir.chdir(folder) do
    file = File.binread(name + ".tga")
    height = file[14..15].reverse.unpack('H*')[0].to_i(16)
    return "File \"#{name}.tga\" doesn't have the right height (has #{height} pixels, should be 64)." if height != 64
    pixel_depth = file[16].unpack('H*')[0].to_i(16)
    return "File \"#{name}.tga\" has an unsupported pixel depth." if ![24, 32].include?(pixel_depth)
    pixel_depth = pixel_depth / 8
    width = file[12..13].reverse.unpack('H*')[0].to_i(16)
    num_colors = width / 64
    return "File \"#{name}.tga\" doesn't have the right amount of colors (has #{colors}, should have #{$objects[name].size})." if num_colors != $objects[name].size
    initial = (file[2] != "\x0A" ? 18 + pixel_depth * 32 * width + pixel_depth * 32 : 19)
    step = (file[2] != "\x0A" ? pixel_depth * 64 : pixel_depth + 1)
    (0 .. num_colors - 1).each{ |i|
      color_code = file[initial + step * i .. initial + step * i + pixel_depth - 1]
      colors << color_code[0..2].reverse.unpack('H*')[0].upcase
    }
  end
  return colors
#rescue => e
#  return "File \"#{name}.tga\" is an invalid .tga palette file:\n\n #{e}"
end

def parse_palette
  dir = Tk.chooseDirectory
  return if !(dir.instance_of?(String) && !dir.empty?)
  Dir.chdir(dir) do
    non_existent = $objects.keys.select{ |f| !File.exists?(f + ".tga") }.compact
    if non_existent.size > 0
      message = "The following files from the palette are missing: #{non_existent.join("\n")}"
      Tk.messageBox('type' => 'ok', 'icon' => 'error', 'title' => 'Error loading palette', 'message' => message)
      return
    end
  end
  $objects.each{ |file, colors|
    parse = parse_file(name: file, folder: dir)
    if parse.instance_of?(String)
      Tk.messageBox('type' => 'ok', 'icon' => 'error', 'title' => 'Error loading palette', 'message' => parse)
      next
    elsif parse.instance_of?(Array)
      parse.each_with_index{ |color, i|
        colors[i][:color] = color
      }
    else
      Tk.messageBox('type' => 'ok', 'icon' => 'error', 'title' => 'Error loading palette', 'message' => 'Unknown error loading palette, please contact Eddy.')
    end
  }
  ColorSelection.update_colors
end

$palette_name = TkEntry.new($root).insert(0, 'palette_name').pack('side' => 'top', 'fill' => 'x', 'expand' => 1)
TkButton.new($root, 'text' => 'Create palette', 'command' => (proc{ create_palette })).pack('side' => 'top', 'fill' => 'x', 'expand' => 1)

Tk.mainloop
