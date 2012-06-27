achievements = require '../achieve'

describe 'Achievements', () ->
  it 'should be able to be defined', (done) ->
    achievements.define ['flag_name'], 
      test : 'a'
    done()
  it 'should be able to add/remove flags', (done) ->
    achievements.flag 'flag2'
    achievements.removeFlag 'flag2'
    done()

  it 'should listen to new achievement events', (done) ->
    achievements.define [ 'f1', 'f2' ],
      test: 1
    achievements.received (achievement) ->
      achievement.test.should.equal(1)
      done()
    achievements.flag 'f1'
    achievements.flag 'f2'

  it 'should listen to remove achievement events', (done) ->
    achievements.removed (achievement) ->
      achievement.test.should.equal(2)
      done()
    achievements.flag 'rf1'
    achievements.flag 'rf2'
    achievements.define ['rf1', 'rf2'],
      test: 2
    achievements.removeFlag 'rf2'

