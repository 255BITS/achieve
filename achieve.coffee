class Achievements
  constructor : () ->
    @flags = {}
    @achievements = []

  define : (requires, achievement) ->
    @achievements.push([requires, achievement])

  received : (callback) ->
    @onAchievement = callback

  removed : (callback) ->
    @onRemoved = callback

  flag : (symbol) ->
    reqMet = (reqs) =>
      unmetReqs = (req for req in reqs when not @flags[req])
      return unmetReqs.length == 1 && 
        unmetReqs[0] == symbol

    unlocked = (ach for ach in @achievements when reqMet(ach[0]))

    if @onAchievement
      @onAchievement(achievement) for [req, achievement] in unlocked

    @flags[symbol]=true

  removeFlag : (symbol) ->
    isReLocked = (reqs) =>
      unmetReqs = (req for req in reqs when not @flags[req])
      symbolMatch = (req for req in reqs when req == symbol)
      hasSymbol = (symbolMatch.length > 0)
      hasSymbol and unmetReqs.length == 0

    locked = (ach for ach in @achievements when isReLocked(ach[0]))
    
    if @onRemoved
      @onRemoved(achievement) for [req, achievement] in locked

    @flags[symbol]=false

achievements = new Achievements()
if window?
  window.achievements = achievements
else
  module.exports = achievements
