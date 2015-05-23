Hubot_Mocha = require './Hubot-Mocha'
Hubot_Geo   = require '../src/Hubot-Geo'

describe '| Hubot-Geo |', ->

  hubot = Hubot_Mocha.new beforeEach, afterEach, Hubot_Geo

  it 'locate ip {ip}',(done)->
    hubot.first_Reply    = (text) =>
      text.assert_Contains "http://maps.googleapis.com/maps/api/staticmap?center=37.419,-122.058"
      done()

    hubot.send_Message 'please locate ip 216.239.38.120'
