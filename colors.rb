require 'tk'

class Block
  attr_reader :text, :color

  def initialize(text: "Sample text", color: "4D564F")
    @text = text
    @color = color
  end
end

background = [
  Block.new(text: "Tiles", color: "4D564F"),
  Block.new(text: "Tile outline", color: "4D564F"),
  Block.new(text: "Background", color: "87948C"),
  Block.new(text: "?", color: "87948C"),
  Block.new(text: "?", color: "87948C"),
  Block.new(text: "Entity outline", color: "87948C")
]

$objects = {
  'background' => background
}
