play = require './play.js'
help = require './help.js'

switch process.argv[2]
  when 'play'
    play process.argv[3]
  when 'help'
    help()
  else
    help()