colors = require 'ansi-256-colors'
config = require './config.js'
Coub = require './coub.js'
cycle = require './cycle.js'

coub = new Coub '93ktc' # test table
# coub = new Coub '7ite5' # vision

# process.stdin.setEncoding 'ascii'
# process.stdin.on 'readable', ->
#   chunk = process.stdin.read()

#   if chunk != null
#     process.stdout.write chunk

# process.stdin.on 'end', ->
#   process.stdout.write '\nend\n'