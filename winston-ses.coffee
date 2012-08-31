winston = require 'winston'
AmazonSES = require 'amazon-ses'

exports.Ses = winston.transports.Ses = class Ses extends winston.Transport
  constructor: (options) ->
    @name = 'ses'
    @level = options.level || 'info'
    @silent = options.silent || false
    @handleExceptions = options.handleExceptions || false

    @sesAccessKey = options.sesAccessKey || ''
    @sesSecretKey = options.sesSecretKey || ''
    @sesFrom = options.sesFrom || ''
    @sesTo = options.sesTo || ''
    @sesSubject = options.sesSubject || ''

    @ses = new AmazonSES(@sesAccessKey, @sesSecretKey)

  log: (level, msg, meta, callback) ->
    if (@silent)
      return callback null, true
    @ses.send
      from: @sesFrom
      to: if Array.isArray(@sesTo) then @sesTo else [@sesTo]
      replyTo: [@sesFrom]
      subject: @sesSubject
      body:
        text: "#{JSON.stringify(msg, null, 2)}\n\n\n#{JSON.stringify(meta, null, 2)}"
    callback null, true