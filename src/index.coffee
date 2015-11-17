Player = require './player/player.js'
permalinkFromURL = require './utils/permalinkFromURL.js'

player = new Player
player.play permalinkFromURL 'http://coub.com/view/97tzi'