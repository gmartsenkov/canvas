require "./cell"

class BackBuffer
  @buffer : Array(Array(Cell))

  getter :buffer
  private setter :buffer

  def initialize(height : UInt16, width : UInt16)
    @buffer = Array.new(height) do
      Array.new(width) { Cell.new }
    end
  end

  def flush(output : IO::FileDescriptor)
    buffer.each_with_index do |cells, row|
      cells.each_with_index do |cell, column|
        output.print("\x1b7\x1b[#{row};#{column}f#{cell.char}\x1b8")
      end
    end
  end

  def set_cell(x : Int32, y : Int32, cell : Cell)
    buffer[x][y] = cell
  end

  def set_cell(x : Int32, y : Int32, char : Char)
    buffer[x][y] = Cell.new(char: char)
  end
end
