require "../src/canvas"

term = Canvas.new(height: 101, width: 101)
term.clear
term.set_cursor(1, 1)
term.set_cell(1, 1, 'e')
term.set_cell(1, 2, 'l')
term.set_cell(10, 20, 'g')
term.flush
sleep 5
term.quit
