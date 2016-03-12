# convert png to compressed array of pixels
pngparse = require 'pngparse'

# convert coordinates to index
c2i = (x, y, w) ->
  w * y + x

convert = (buffer, callback) ->
  pngparse.parse buffer, (err, data) ->
    if err
      throw err

    compressed = []

    iw = data.width             # image width
    ih = data.height            # image height
    tw = process.stdout.columns # terminal width
    th = process.stdout.rows    # terminal height
    sx = Math.round iw / tw     # step x (ceil cause we want to fill all screen)
    sy = Math.round ih / th     # step y
    sm = sx * sy                # step multiplier

    # temporary vars
    r = 0
    g = 0
    b = 0

    x = 0
    y = 0

    rows = 1

    i = 0

    # begin?¿?
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

    callback compressed

# export
module.exports = convert