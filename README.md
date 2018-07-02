# Canvas

Library with a simple API that lets you draw in the terminal.
Only tested on MacOS with iTerm

Example code:

```
term = Canvas.new(height: 100, width: 100)
term.clear
term.set_cursor(1, 1)
term.set_cell(1, 1, 't')
term.set_cell(1, 2, 'e')
term.set_cell(1, 3, 's')
term.set_cell(1, 4, 't')
term.flush
sleep 5
term.quit
```
