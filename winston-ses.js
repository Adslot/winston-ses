(function() {
  var AmazonSES, Ses, winston,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  winston = require('winston');

  AmazonSES = require('amazon-ses');

  exports.Ses = winston.transports.Ses = Ses = (function(_super) {

    __extends(Ses, _super);

    function Ses(options) {
      this.name = 'ses';
      this.level = options.level || 'info';
      this.silent = options.silent || false;
      this.handleExceptions = options.handleExceptions || false;
      this.sesAccessKey = options.sesAccessKey || '';
      this.sesSecretKey = options.sesSecretKey || '';
      this.sesFrom = options.sesFrom || '';
      this.sesTo = options.sesTo || '';
      this.sesSubject = options.sesSubject || '';
      this.ses = new AmazonSES(this.sesAccessKey, this.sesSecretKey);
    }

    Ses.prototype.log = function(level, msg, meta, callback) {
      if (this.silent) return callback(null, true);
      this.ses.send({
        from: this.sesFrom,
        to: Array.isArray(this.sesTo) ? this.sesTo : [this.sesTo],
        replyTo: [this.sesFrom],
        subject: this.sesSubject,
        body: {
          html: "" + (JSON.stringify(msg)) + "\n\n\n" + (JSON.stringify(meta))
        }
      });
      return callback(null, true);
    };

    return Ses;

  })(winston.Transport);

}).call(this);
