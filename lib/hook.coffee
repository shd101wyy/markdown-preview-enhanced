###
Very simple synchronous Hook library
For async, please use Emitter

eg:

  hook = new Hook()
  hook.on 'add', (num)->
    num+1
  hook.on 'add', (num)->
    num+2

  hook.chain 'add', 3  # => 6

###

class Hook
  constructor: ->
    @subcriptions = {}

  on: (name, callback)->
    if @subcriptions[name]
      @subcriptions[name].push callback
    else
      @subcriptions[name] = [callback]

  chain: (name, args)->
    if @subcriptions[name]
      funcs = @subcriptions[name]
      value = args
      for func in funcs
        value = func(value)
      value
    else
      args

  dispose: ->
    @subcriptions = null

module.exports = Hook
