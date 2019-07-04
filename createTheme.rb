require 'tk'
require_relative 'colors.rb'

$root = TkRoot.new('title' => 'N++ Palette Creator')
$root.minsize(480,480)
$root.grid_rowconfigure(1, 'weight' => 1)
$root.grid_columnconfigure(0, 'weight' => 1)

TkButton.new($root, 'text' => 'Load palette', 'command' => (proc{ parse_palette })).grid('row' => 0, 'column' => 0, 'sticky' => 'ew')

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
    @text = TkLabel.new(self, 'anchor' => 'w', 'justify' => 'left', 'text' => object[:text], 'wraplength' => 800).pack('side' => 'left')
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

class ElementList < TkListbox
  def initialize(frame, tab, list)
    super(frame, 'width' => 20, 'listvariable' => TkVariable.new(list), 'selectmode' => 'single')
    @list = list
    @tab = tab
    self.bind("Double-Button-1"){ change_frame }
  end

  def change_frame
    $frames[@tab].each{ |e, frame| frame.grid_remove }
    $frames[@tab][self.get("active").to_s].grid
  end
end

notebook = Tk::Tile::Notebook.new($root).grid('row' => 1, 'column' => 0, 'sticky' => 'ewns')
notebook.grid_rowconfigure(0, 'weight' => 1)
notebook.grid_columnconfigure(0, 'weight' => 1)
tabs = {
  'Objects' => TkFrame.new(notebook).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns'),
  'Menu' => TkFrame.new(notebook).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns'),
  'Editor' => TkFrame.new(notebook).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns'),
  'Timebar' => TkFrame.new(notebook).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns'),
  'Headbands' => TkFrame.new(notebook).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns'),
  'Effects' => TkFrame.new(notebook).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns')
}
tabs.each{ |tab, frame|
  frame.grid_rowconfigure(0, 'weight' => 1)
  frame.grid_columnconfigure(1, 'weight' => 1)
}
tabs.each{ |tab, frame| notebook.add(frame, 'text' => tab) }

$elements = {
  'Objects' => [
    {name: 'background', title: 'Background'},
    {name: 'ninja', title: 'Ninja'},
    {name: 'entityMine', title: 'Mine'},
    {name: 'entityGold', title: 'Gold'},
    {name: 'entityDoorExit', title: 'Exit door'},
    {name: 'entityDoorExitSwitch', title: 'Exit switch'},
    {name: 'entityDoorRegular', title: 'Regular door'},
    {name: 'entityDoorLocked', title: 'Locked door'},
    {name: 'entityDoorTrap', title: 'Trap door'},
    {name: 'entityLaunchPad', title: 'Launchpad'},
    {name: 'entityOneWayPlatform', title: 'Oneway platform'},
    {name: 'entityDroneChaingun', title: 'Chaingun Drone'},
    {name: 'entityDroneLaser', title: 'Laser drone'},
    {name: 'entityDroneZap', title: 'Zap drone'},
    {name: 'entityDroneChaser', title: 'Chaser drone'},
    {name: 'entityFloorGuard', title: 'Floorguard'},
    {name: 'entityBounceBlock', title: 'Bounce block'},
    {name: 'entityRocket', title: 'Rocket'},
    {name: 'entityTurret', title: 'Gauss turret'},
    {name: 'entityThwomp', title: 'Thwump'},
    {name: 'entityEvilNinja', title: 'Evil ninja'},
    {name: 'entityDualLaser', title: 'Laser turret'},
    {name: 'entityBoostPad', title: 'Boost pad'},
    {name: 'entityBat', title: 'Deathball'},
    {name: 'entityEyeBat', title: 'Mini'},
    {name: 'entityShoveThwomp', title: 'Shove thwump'}
  ],
  'Menu' => [
    {name: 'menu', title: 'Menus', indexes: [0, 3, 4, 10, 17, 29]},
    {name: 'menu', title: 'Tabs', indexes: [8, 12, 25, 26, 27, 31, 33, 37]},
    {name: 'menu', title: 'Leaderboards', indexes: [1, 2, 13, 16, 32]},
    {name: 'menu', title: 'Episode / Levels', indexes: [5, 7, 9, 22, 23, 30]},
    {name: 'menu', title: 'Pause menu', indexes: [18, 19, 20, 21]},
    {name: 'menu', title: 'Profile', indexes: [14, 15]},
    {name: 'menu', title: 'Other texts', indexes: [24, 28, 34, 35, 38, 40, 41]}
  ],
  'Editor' => [],
  'Timebar' => [],
  'Headbands' => [],
  'Effects' => [
    {name: 'explosions', title: 'Explosions'},
    {name: 'fxDroneZap', title: 'Drone zapping'},
    {name: 'fxFloorguardZap', title: 'Floorguard zapping'},
    {name: 'fxNinja', title: 'Ground dust'}
  ]
}
$lists = tabs.map{ |tab, frame| [tab, ElementList.new(frame, tab, $elements[tab].map{ |e| e[:title] }).grid('row' => 0, 'column' => 0, 'sticky' => 'ewns')] }.to_h
$frames = $elements.map{ |tab, els|
  tab_frames = els.map{ |e| [e[:title], TkFrame.new(tabs[tab]).grid('row' => 0, 'column' => 1, 'sticky' => 'ewns')] }.to_h
  [tab, tab_frames]
}.to_h

$elements.each{ |tab, els|
  els.each{ |e|
    if e.key?(:indexes)
      get_objects(e[:name], e[:indexes]).each_with_index{ |o, i| ColorSelection.new($frames[tab][e[:title]], o, i, 0) }
    else
      get_objects(e[:name]).each_with_index{ |o, i| ColorSelection.new($frames[tab][e[:title]], o, i, 0) }
    end
  }
}

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
    return "File \"#{name}.tga\" doesn't have the right amount of colors (has #{num_colors}, should have #{$objects[name].size})." if num_colors != $objects[name].size
    initial = (file[2] != "\x0A" ? 18 + pixel_depth * 32 * width + pixel_depth * 32 : 19)
    step = (file[2] != "\x0A" ? pixel_depth * 64 : pixel_depth + 1)
    (0 .. num_colors - 1).each{ |i|
      color_code = file[initial + step * i .. initial + step * i + pixel_depth - 1]
      colors << color_code[0..2].reverse.unpack('H*')[0].upcase
    }
  end
  return colors
rescue => e
  return "File \"#{name}.tga\" is an invalid .tga palette file:\n\n #{e}"
end

def parse_palette
  dir = Tk.chooseDirectory
  return if !(dir.instance_of?(String) && !dir.empty?)
  Dir.chdir(dir) do
    non_existent = $objects.keys.select{ |f| !File.exists?(f + ".tga") }.compact
    if non_existent.size > 0
      message = "The following files from the palette are missing:\n#{non_existent.join("\n")}"
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

$palette_name = TkEntry.new($root).insert(0, 'palette_name').grid('row' => 2, 'column' => 0, 'sticky' => 'ew')
TkButton.new($root, 'text' => 'Create palette', 'command' => (proc{ create_palette })).grid('row' => 3, 'column' => 0, 'sticky' => 'ew')

Tk.mainloop
