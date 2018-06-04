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
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e44930ab5aefcbdb724eb7b616edd4e55a7ad55c/miro-miel",
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
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--89ed4c58348dcdb82497e37d610bcddf4bfb61f8/cumberland-punch",
                  "text": "American Wheat Ale",
                  "title": "Cumberland Punch"
                },
                {
                  "fallback": "Young Hickory (ABV: 4.5%) - Hickory Smoked Porter ",
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
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--b4d8524dd7e6e435b6c921024f2f45f46e0ccc5c/young-hickory",
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
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBMdz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--76974406805fe21708003a54eaba241dad4cbd34/roaming-dog",
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
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--bb13b6f3358f152e943e19a1aafae3b25ee42838/swing-bridge-ipa",
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
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--dcba9ea94cf6f2b391e669e41ecf277ff5268bc0/east-bank",
                  "text": "Citra IPA",
                  "title": "East Bank"
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
                  "thumb_url": "http://enbw.herokuapp.com/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBNZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--00ec31783a9219994771227f54bbea1c4b194922/woodland-hull-melon",
                  "text": "Session IPA w/ GER Hull Melon Hops",
                  "title": "Woodland Hull Melon"
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
                  "thumb_url": null,
                  "text": "APA w/ Hallertau Blanc Hops",
                  "title": "Holla Blanc"
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
                  "thumb_url": null,
                  "text": "IPA, Amarillo and Citra hops",
                  "title": "Wes Coast Hamatrillo"
                },
                {
                  "fallback": "Talbot's Corner (ABV: 6.0%) - Belgian style witbier.  ",
                  "fields": [
                    {
                      "short": true,
                      "title": "ABV %",
                      "value": "6.0%"
                    },
                    {
                      "short": true,
                      "title": "Price Tier",
                      "value": "1"
                    }
                  ],
                  "thumb_url": null,
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
                  ],
                  "thumb_url": null,
                  "text": "Malty red w/ NZ hops",
                  "title": "Fire of the Century"
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
