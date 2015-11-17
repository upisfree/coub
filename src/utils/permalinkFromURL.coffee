# get video permalink from video url
url = require 'url'

permalinkFromURL = (link) ->
  link = url.parse(link).pathname.split('/')[2]

# export
module.exports = permalinkFromURL