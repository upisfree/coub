fs = require 'fs'
request = require 'request'
FFmpeg = require 'plain-ffmpeg'
shell = require 'shelljs'
api = require './api.js'
config = require './config.js'

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
   
      @video = @json.file_versions.web.template.replace(/\%\{type\}/g, 'mp4').replace(/\%\{version\}/g, 'big')

      # download video
      request.get @video
             .pipe fs.createWriteStream "#{config.tmp}input.mp4"
             .on 'finish', ->
                # create frames
                shell.exec "ffmpeg -i #{config.tmp}input.mp4 -r 30 #{config.tmp}output_%04d.png"

  onready: ->

# export
module.exports = Coub