require "./canvas/back_buffer"

class Canvas
  @back_buffer : BackBuffer
  @input_channel = Channel(Bytes).new
  @interrupt_channel = Channel(Nil).new
  @stdout = IO::FileDescriptor.new(2, blocking: (LibC.isatty(2)) == 0)
  @stdin = STDIN

  getter :height, :width

  private property :back_buffer
  private getter :input_channel, interrupt_channel
  private getter :stdin, :stdout

  delegate set_cell, to: :back_buffer

  def initialize(@height : Int32, @width : Int32)
    listen_on_stdin
    @back_buffer = BackBuffer.new(
      height: UInt16.new(@height),
      width: UInt16.new(@width)
    )
  end

  def clear
    stdout.print "\033[2J"
    flush
  end

  def flush
    back_buffer.flush(stdout)
    stdout.flush
  end

  def interupt
    interrupt_channel.send(nil)
  end

  def poll_event
    loop do
      select
      when key = input_channel.receive
        return key
      when interrupt_channel.receive
        return
      end
    end
  end

  def set_cursor(x, y)
    stdout.print "\033[#{x};#{y}f"
    stdout.flush
  end

  def quit
    input_channel.close
    interrupt_channel.close
    set_cursor(0, 0)
    stdin.cooked!
    stdout.cooked!
    clear
    flush
  end

  private def listen_on_stdin
    spawn do
      loop do
        stdin.raw do |x|
          key = Bytes.new(1)
          x.read(key)
          input_channel.send(key)
        end
      end
    end
  end
end
