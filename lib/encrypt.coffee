crypto = require 'crypto'
algorithm = 'aes-256-ctr'

encrypt = (text)->
  cipher = crypto.createCipher(algorithm, "jdasnfklq")
  crypted = cipher.update(text, 'utf8', 'hex')
  crypted += cipher.final('hex')
  crypted

module.exports = encrypt