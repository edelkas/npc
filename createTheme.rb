require 'tk'
require_relative 'colors.rb'

$root = TkRoot.new('title' => 'N++ Palette Creator')
load_palette = TkButton.new($root, 'text' => 'Load palette', 'command' => (proc{ create_palette })).pack('side' => 'top', 'fill' => 'x', 'expand' => 1)

class ColorSelection < TkFrame
  def initialize(frame, object, row, column)
    super(frame)
    @object = object
    @button = TkButton.new(self){
      text ''
      width 2
      height 2
      background ('#' + object[:color])
      command proc{
        color = Tk.chooseColor('initialcolor' => self.cget('background'))
        if color.is_a?(String) && color.size > 2
          self.configure('background', color)
          @object[:color] = color
        end
      }
    }
    @button.pack('side' => 'left')
    @text = TkLabel.new(self, 'anchor' => 'w', 'text' => object[:text]).pack('side' => 'left')
    self.grid('row' => row, 'column' => column, 'sticky' => 'w')
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
          image << "\xBF".force_encoding('ASCII-8BIT') + [color].pack('H*')
        end
      end
      f.write(image)
    end
  end
end

def create_palette
  Dir.mkdir($palette_name.get()) unless File.exists?($palette_name.get())
  create_file(folder: $palette_name.get(), colors: $objects['background'].map(&:color))
end

palette_name = TkEntry.new($root).insert(0, 'palette_name').pack('side' => 'top', 'fill' => 'x', 'expand' => 1)
create_palette = TkButton.new($root, 'text' => 'Create palette', 'command' => (proc{ create_palette })).pack('side' => 'top', 'fill' => 'x', 'expand' => 1)

Tk.mainloop
