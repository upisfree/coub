fs = require 'fs'
request = require 'request'
api = require './api.js'

class Coub
  constructor: (@permalink) ->
    api.getCoub @permalink, (res) ->
      @json = JSON.parse res
      @title = @json.title

      # dev mode, TODO: make normal
      @url = @json.file_versions.web.template.replace(/\%\{type\}/g, 'mp4').replace(/\%\{version\}/g, 'big')
      
      request(@url).pipe fs.createWriteStream('./bin/video.mp4')
  onready: ->

# export
module.exports = Coub