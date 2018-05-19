class Cell
  @char = ' '
  @background : Nil | UInt8
  @foreground : Nil | UInt8
  property :char, :background, :foreground

  def initialize(@char = ' ', @background = nil, @foreground = nil); end
end
