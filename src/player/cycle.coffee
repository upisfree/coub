# I can't use “loop” word :(
fs = require 'fs'
path = require 'path'
config = require '../config.js'
print = require './print.js'

cycle = ->
  buffers = []

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
        print buffers[i]
        i++
    , 15
# export
module.exports = cycle