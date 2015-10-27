request = require 'request'
config = require './config.js'

api =
  getCoub: (permalink, callback) ->
    request "http://coub.com/api/v#{config.apiVersion}/coubs/#{permalink}", (e, res, body) ->
      if not e and res.statusCode is 200
        callback body
      else
        throw e

# export
module.exports = api