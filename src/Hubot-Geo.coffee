# Commands:
# tbot locate ip {ip or domain} - Returns details and map of ip (using www.freegeoip.net)

require 'fluentnode'

module.exports = (robot) ->

  robot.hear /locate ip (.*)/i, (msg)->
    ip = msg.match[1].remove('http://').remove('tel:')
    url = "http://www.freegeoip.net/json/#{ip}"
    log url
    url.GET_Json (data)->

      url_Map = "http://maps.googleapis.com/maps/api/staticmap?center=#{data.latitude},#{data.longitude}&zoom=12&size=800x900&sensor=false"
      log url
      msg.reply data.json_Str() + "\n\n" + url_Map
