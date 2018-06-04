Helper = require 'hubot-test-helper'
chai = require 'chai'
nock = require 'nock'
fs = require 'fs'

expect = chai.expect

helper = new Helper [
  '../src/enbw.coffee'
]

# Alter time as test runs
originalDateNow = Date.now
mockDateNow = () ->
  return Date.parse('Tue May 24 2018 23:01:27 GMT-0600 (CST)')

describe 'hubot-enbw', ->
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
            'hubot',
            "On Tap at ENBW\n" +
            "--------------------------------------------------------------------\n" +
            "| Name                 | ABV  | Description                        |\n" +
            "--------------------------------------------------------------------\n" +
            "| Miro Miel            | 5.2% | Blonde Ale with Local Honey        |\n" +
            "| Cumberland Punch     | 6.2% | American Wheat Ale                 |\n" +
            "| Young Hickory        | 4.5% | Hickory Smoked Porter              |\n" +
            "| Roaming Dog          | 5.2% | ESB + APA = ASB                    |\n" +
            "| Swing Bridge IPA     | 6.5% | American IPA                       |\n" +
            "| East Bank            | 7.0% | Citra IPA                          |\n" +
            "| Woodland Hull Melon  | 4.5% | Session IPA w/ GER Hull Melon Hops |\n" +
            "| Holla Blanc          | 5.2% | APA w/ Hallertau Blanc Hops        |\n" +
            "| Wes Coast Hamatrillo | 7.2% | IPA, Amarillo and Citra hops       |\n" +
            "| Talbot's Corner      | 6.0% | Belgian style witbier.             |\n" +
            "| Fire of the Century  | 5.5% | Malty red w/ NZ hops               |\n" +
            "--------------------------------------------------------------------"
          ]
        ]
        done()
      catch err
        done err
      return
    , 1000)
