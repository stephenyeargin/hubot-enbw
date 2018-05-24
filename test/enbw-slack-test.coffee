Helper = require 'hubot-test-helper'
chai = require 'chai'
nock = require 'nock'
fs = require 'fs'

expect = chai.expect

helper = new Helper [
  'adapters/slack.coffee',
  '../src/enbw.coffee'
]

# Alter time as test runs
originalDateNow = Date.now
mockDateNow = () ->
  return Date.parse('Tue May 24 2018 23:01:27 GMT-0600 (CST)')

describe 'hubot-enbw for slack', ->
  beforeEach ->
    Date.now = mockDateNow
    @room = helper.createRoom()
    nock.disableNetConnect()

  afterEach ->
    Date.now = originalDateNow
    @room.destroy()
    nock.cleanAll()

  it 'retrieves the current beer on tap', (done) ->
    options =
      reqheaders:
        accept: "application/json"
    nock('https://enbw.herokuapp.com', options)
      .get('/')
      .reply 200, fs.readFileSync('test/fixtures/beers.json')

    selfRoom = @room
    selfRoom.user.say('alice', '@hubot enbw')
    setTimeout(() ->
      try
        expect(selfRoom.messages).to.eql [
          ['alice', '@hubot enbw']
          [
            "hubot",
            {
              "attachments": [
                {
                  "fallback": "Miro Miel (ABV: 5.2%) - Blonde Ale with Local Honey",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "5.2%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "https://drive.google.com/uc?export=view&id=1MbQBq0T4AEUskryS_XiXw1p_3xBMn45n",
                  "text": "Blonde Ale with Local Honey",
                  "title": "Miro Miel"
                },
                {
                  "fallback": "Cumberland Punch (ABV: 6.2%) - American Wheat Ale",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "6.2%"
                    }
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "https://drive.google.com/uc?export=view&id=1dweo6z4gB7evG4FqCi_EwfRGah2W8p8A",
                  "text": "American Wheat Ale",
                  "title": "Cumberland Punch"
                },
                {
                  "fallback": "Young Hickory (ABV: 4.5%) - Hickory Smoked Porter "
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "4.5%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "https://drive.google.com/uc?export=view&id=1momjCj2roVpj9rrfBrUOZnVfdNzbM8Yj",
                  "text": "Hickory Smoked Porter ",
                  "title": "Young Hickory"
                },
                {
                  "fallback": "Roaming Dog (ABV: 5.2%) - ESB + APA = ASB",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "5.2%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "https://drive.google.com/uc?export=view&id=1o5_PA2_3G7IdFnUq228DMysj18iAO4Dp",
                  "text": "ESB + APA = ASB",
                  "title": "Roaming Dog"
                },
                {
                  "fallback": "Swing Bridge IPA (ABV: 6.5%) - American IPA",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "6.5%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "2"
                    }
                  ],
                  "thumb_url": "https://drive.google.com/uc?export=view&id=1VircCiu-t-IZyiswAepAyOVRYjWosb45",
                  "text": "American IPA",
                  "title": "Swing Bridge IPA"
                },
                {
                  "fallback": "East Bank (ABV: 7.0%) - Citra IPA",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "7.0%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "2"
                    }
                  ],
                  "thumb_url": "https://cdn.lstoll.net/screen/East-Bank.svg_-_Google_Drive_2018-03-01_22-37-44.png",
                  "text": "Citra IPA",
                  "title": "East Bank"
                },
                {
                  "fallback": "Wes Coast Hamatrillo (ABV: 7.2%) - IPA, Amarillo and Citra hops",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "7.2%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "2"
                    }
                  ],
                  "thumb_url": "http://www.eastnashbeerworks.com/_assets/img/global/logo.svg",
                  "text": "IPA, Amarillo and Citra hops",
                  "title": "Wes Coast Hamatrillo"
                },
                {
                  "fallback": "Holla Blanc (ABV: 5.2%) - APA w/ Hallertau Blanc Hops",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "5.2%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "http://www.eastnashbeerworks.com/_assets/img/global/logo.svg",
                  "text": "APA w/ Hallertau Blanc Hops",
                  "title": "Holla Blanc"
                },
                {
                  "fallback": "Talbot's Corner (ABV: 6.0%) - Belgian style witbier.  ",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "6.0%"
                    }
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "http://www.eastnashbeerworks.com/_assets/img/global/logo.svg",
                  "text": "Belgian style witbier.  ",
                  "title": "Talbot's Corner"
                },
                {
                  "fallback": "Fire of the Century (ABV: 5.5%) - Malty red w/ NZ hops",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "5.5%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ]
                  "thumb_url": "http://www.eastnashbeerworks.com/_assets/img/global/logo.svg",
                  "text": "Malty red w/ NZ hops",
                  "title": "Fire of the Century"
                },
                {
                  "fallback": "Woodland Hull Melon (ABV: 4.5%) - Session IPA w/ GER Hull Melon Hops",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "4.5%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "https://drive.google.com/uc?export=view&id=1kGAaTejx1W-bmJMiaTw2x5k_dxmjNhBV",
                  "text": "Session IPA w/ GER Hull Melon Hops",
                  "title": "Woodland Hull Melon"
                }
              ],
              "text": "On tap at East Nashville Beer Works",
              "unfurl_links": false
            }
          ]
        ]
        done()
      catch err
        done err
      return
    , 1000)
