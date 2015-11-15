fs = require 'fs'
request = require 'request'
FFmpeg = require 'plain-ffmpeg'
shell = require 'shelljs'
config = require './config.js'
api = require './api.js'
cycle = require './cycle.js'

class Coub
  constructor: (@permalink) ->
    api.getCoub @permalink, (res) ->
      @json = JSON.parse res
      @title = @json.title

      # dev mode, TODO: make normal
      # if @json.audio_versions.template
      #   @audio = @json.audio_versions.template.replace(/\%\{version\}/g, 'high')
      # 
      # if @audio
      #   request(@audio).pipe fs.createWriteStream './bin/tmp/input.mp3'
   
      fs.writeFile 'tmp/test.json', JSON.stringify @json

      @video = @json.file_versions.web.template.replace(/\%\{type\}/g, 'mp4').replace(/\%\{version\}/g, 'small')

      # download video
      request.get @video
             .pipe fs.createWriteStream "#{config.tmp}input.mp4"
             .on 'finish', ->
                # create frames
                shell.exec "ffmpeg -i #{config.tmp}input.mp4 -r 25 #{config.tmp}frame_%3d.png"
                
                cycle()
  onready: ->

# export
module.exports = Coub