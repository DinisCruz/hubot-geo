Robot    = require 'hubot/src/robot'
messages = require 'hubot/src/message'

class Hubot_Mocha
  constructor: (options)->
    @.options      = options        || {}
    @.name         = @.options.name || 'TBot'
    @.robot        = null
    @.user         = null
    @.on_Connected = null
    @.on_Send      = null
    @.on_Reply     = null
    @.first_Reply  = null

  setup: =>
    @.robot = new Robot(null, 'mock-adapter', false, @.name)
    @.robot.adapter.on 'connected', ()                => @.on_Connected?()
    @.robot.adapter.on 'send'     , (envelope,strings)=> @.on_Send?(envelope,strings)
    @.robot.adapter.on 'reply'    , (envelope,strings)=> @.on_Reply?(envelope,strings)
    @.robot.adapter.on 'reply'    , (envelope,strings)=> @.first_Reply?(strings.first())
    @.user = @.robot.brain.userForId '1', { name: @.name.append('-user'), room: '#tbot'}
    @

  run: (callback)=>
    @.setup() unless @.robot
    @.on_Connected = ()=> callback @
    @.robot.run()

  send_Message: (text)=>
    @.robot.adapter.receive new messages.TextMessage(@.user, text)

  say: (text)=>
    @.send_Message "tbot #{text}"


Hubot_Mocha.new = (beforeEach, afterEach, target, on_Robot)->

  hubot_Mocha = new Hubot_Mocha()

  beforeEach (callback)->
    hubot_Mocha.run ->
      target? hubot_Mocha.robot
      on_Robot? hubot_Mocha.robot
      callback()

  afterEach (callback)->
    hubot_Mocha.robot.shutdown()
    callback()

  return hubot_Mocha

module.exports = Hubot_Mocha
