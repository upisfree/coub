colors = require 'ansi-256-colors'
convert = require './convert.js'

CHAR_FULL_BLOCK = String.fromCharCode 9608

show = (buffer) ->
  convert buffer, (data) -> # data is an array of rgb pixels
    w = process.stdout.columns
    str = ''
    i = 0

    process.stdout.cursorTo 0, 0

    while i < data.length
      if i % w is 0 and i isnt 0
        process.stdout.write str
        str = ''

      r = Math.round data[i][0] / 255 * 5
      g = Math.round data[i][1] / 255 * 5
      b = Math.round data[i][2] / 255 * 5
      
      str += colors.fg.getRgb(r, g, b) +
             CHAR_FULL_BLOCK

      i++

# export
module.exports = show