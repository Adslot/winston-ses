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
    msg = if typeof msg is 'object' then JSON.stringify(msg, null, 2) else msg
    meta = if typeof msg is 'object' then JSON.stringify(msg, null, 2) else meta
    @ses.send
      from: @sesFrom
      to: if Array.isArray(@sesTo) then @sesTo else [@sesTo]
      replyTo: [@sesFrom]
      subject: @sesSubject
      body:
        text: "#{msg}\n\n\n#{meta}"
        html: "<pre>#{msg}\n\n\n#{meta}</pre>"
    callback null, true