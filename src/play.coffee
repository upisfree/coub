help = require './help.js'
Player = require './player/player.js'
permalinkFromURL = require './utils/permalinkFromURL.js'

play = (url) ->
  if not url
    help()
    return

  console.log 'Loading coub...'

  player = new Player
  player.play permalinkFromURL url

# export
module.exports = play