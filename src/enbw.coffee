# Description:
#   Get the latest on-tap information from East Nashville Beer Works
#
# Commands:
#   hubot enbw - Get the latest beer on tap at East Nashville Beer Works
#
# Author:
#   bval, stephenyeargin

asciitable = require 'asciitable'

module.exports = (robot) ->
  robot.respond /(?:enbw|what's on tap)$/i, (msg) ->
    getENBWAPIResponse msg, (data) ->
      data = data['beers'].map (beer) ->
        name: beer.name,
        abv: "#{beer.abv}%",
        description: "#{beer.tag_line}",
        image: beer.image_url,
        tier: "#{beer.tier_id}"

      switch robot.adapterName
        when 'slack'
          payload = {
            text: "On tap at East Nashville Beer Works",
            attachments: [],
            unfurl_links: false
          }
          for beer in data
            payload.attachments.push {
              title: "#{beer.name}",
              text: "#{beer.description}"
              fallback: "#{beer.name} (ABV: #{beer.abv}) - #{beer.description}",
              thumb_url: if beer.image? then beer.image else null,
              fields: [
                {
                  title: "ABV %",
                  value: "#{beer.abv}",
                  short: true
                },
                {
                  title: "Price Tier",
                  value: "#{beer.tier}",
                  short: true
                }
              ]
            }
          robot.logger.debug JSON.stringify(payload)
          msg.send payload
        else
          options =
            skinny: true,
            columns:
              [
                { field: "name", name: "Name" }
                { field: "abv", name: "ABV" }
                { field: "description", name: "Description"}
              ]
          msg.send "On Tap at ENBW\n" + asciitable options, data

  getENBWAPIResponse = (msg, cb) ->
    url = "https://enbw.herokuapp.com"
    robot.logger.debug url
    robot.http(url)
      .header('Accept', 'application/json')
      .get() (err, res, body) ->
        if !body
          return msg.send "No data returned."
        response = JSON.parse(body)
        if err
          return msg.send err
        if response.error
          return msg.send response.error
        cb(response)
