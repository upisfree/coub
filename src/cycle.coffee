# I can't use “loop” word :(
fs = require 'fs'
path = require 'path'
config = require './config.js'
show = require './show.js'

cycle = ->
  buffers = []

  # console.log process.stdout

  # rr = fs.createReadStream '/dev/stdout'
  # rr.on 'readable', ->
  #   console.log 'readable:', rr.read()

  # rr.on 'end', ->
  #   console.log 'end'

  # fs.readFile '/dev/stdout', (err2, data) ->
  #   console.log err2, data

  fs.readdir config.tmp, (err, files) ->
    for i in files
      if err
        throw err

      if path.extname(i) is '.png'
        fs.readFile path.join(config.tmp, i), (err2, data) ->
          if err2
            throw err2

          buffers.push data

    i = 0
    setInterval ->
      # endless loop!
      if i >= buffers.length
        i = 0

      if buffers.length isnt 0
        # time = Date.now()
        # show buffers[0]
        # console.log Date.now() - time
        show buffers[i]
        i++
    , 15
# export
module.exports = cycle