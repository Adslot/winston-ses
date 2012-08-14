# winston-ses

A [Amazon SES][2] transport for [winston][0]. Inspired by [winston-graylog2][1] transport and [amazon-ses][3].

## Installation
Tested on node-0.6.x, requires npm.

``` sh
  $ npm install winston-ses
```

## Usage
``` js
  var winston = require('winston');
  winston.add(require('winston-ses').Ses, options);

```

Options are the following:

* __level:__ Level of messages this transport should log. (default: info)
* __silent:__ Boolean flag indicating whether to suppress output. (default: false)

* __sesAccessKey:__ Your SES access key.
* __sesSecretKey:__ Your SES secret key.
* __sesFrom:__ From email address.
* __sesTo:__ To email address (can be an array of email addesses or a string)
* __sesSubject:__ Email subject line

[0]: https://github.com/flatiron/winston
[1]: https://github.com/flite/winston-graylog2
[2]: http://aws.amazon.com/ses/
[3]: https://github.com/jjenkins/node-amazon-ses