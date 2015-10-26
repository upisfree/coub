request = require 'request'
config = require './config.js'

api =
  getCoub: (permalink, callback) ->
    request "http://coub.com/api/v#{config.apiVersion}/coubs/#{permalink}", (error, res, body) ->
      if not error and res.statusCode is 200
        callback body
      else
        throw error

# export
module.exports = api