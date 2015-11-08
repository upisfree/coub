# convert png to array of pixels
fs = require 'fs'
pngparse = require 'pngparse'
colors = require 'ansi-256-colors'
config = require './config.js'
require './utils.js'


# convert coordinates to index
c2i = (x, y, w) ->
  w * y + x

convert = ->
  pngparse.parseFile "#{config.tmp}output_0001.png", (err, data) ->
    if err
      throw err

    # copmress
    compressed = []

    iw = data.width             # image width
    ih = data.height            # image height
    tw = process.stdout.columns # terminal width
    th = process.stdout.rows    # terminal height
    sx = iw / tw                # step x
    sy = ih / th                # step y
    sm = sx * sy                # step multiplier
    
    # temporary vars
    r = 0
    g = 0
    b = 0

    x = 0
    y = 0

    rows = 1

    i = 0

    # compressing...
    while i < data.data.length # data.data is Uint8ClampedArray of rgb(a) values
      if i % data.channels and i isnt 0 # data.channels is usualy 3 — rgb
        # check x border
        if x % sx is 0 and x isnt 0
          x -= sx
          y++

        # check y border
        if y % (sy * rows) is 0 and y isnt 0 and x isnt 0
          y -= sy
          x += sx # balance `x -= sx` (know better solutions? pull it or write to @upisfree :)

          # push and reset
          compressed.push [Math.round(r / sm)
                           Math.round(g / sm)
                           Math.round(b / sm)]

          r = 0
          g = 0
          b = 0

          # check image x border
          if x is iw
            x = 0
            rows++
            y += sy # balance `x -= sx` (know better solutions? pull it or write to @upisfree :)

        index = c2i(x, y, iw) * 3

        if index > data.data.length
          break

        r += data.data[index]
        g += data.data[index + 1]
        b += data.data[index + 2]

        x++
      i++

    # WRITE
    str = ''
    CHAR_HALF_BLOCK = String.fromCharCode 9604

    for i in compressed
      r = Math.round i[0] / 255 * 5
      g = Math.round i[1] / 255 * 5
      b = Math.round i[2] / 255 * 5
      
      str += colors.bg.getRgb(r, g, b) +
             colors.fg.getRgb(r, g, b) +
             CHAR_HALF_BLOCK

    process.stdout.cursorTo 0, 0
    console.log str

    # fs.writeFile config.tmp + 'test.json', JSON.stringify compressed

# export
module.exports = convert