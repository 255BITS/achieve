# Achieve
This API is a framework/persistence agnostic API for defining user-based
Achievements.

#High Level Overview:
* Achievements are defined as a list of required flags.
* Flags are set in the browser when a user reaches certain checkpoints.
* User-defined events are triggered when achievements get all the required flags.

#Typical usage
* `define` your list of achievements
* Add a listener for the `recieved` and `removed` events
* As the user does certain actions, add and remove `flags`

#API Documentation
##achievements
###define(required, achievement)
This creates a new achievement definition.  This will not give a user an achievement.
`required` is a list of flags that the achievement requires to activate
`achievement` is the achievement object that is passed to the listening callback

####Example
```coffeescript
achievements.define(['validPicture', 'validName'], {
  name: 'profileSetup',
  icon: '/badges/profileSetup.png',
  message: 'Congratulations!  Your profile is now setup.',
  removalMessage: "Fix your profile buddy."
})
```

###flag(bit)
`bit` is a symbol designating the name of the flag.
This will toggle a flag as ON.  If the correct flags are set to ON, a `received` event is triggered.  Events are 
only triggered once, when all required flags are set to ON.

####Example
```coffeescript
achievements.flag('validPicture')
achievements.flag('validName')
```

###removeFlag(bit)
`bit` is a symbol designating the name of the flag.
This will toggle a flag as OFF.  If an active achievements required flag is set to OFF, a `removed` event is triggered.  Events
are only triggered once, when any of the required flags are set to OFF.

####Example
```coffeescript
achievements.removeFlag('validPicture')
```

###received(callback)
`callback` is a function that will execute when a new achievement is received.

####Example
```coffeescript
achievements.received (achievement) ->
  console.log("User has a new achievement!")
  console.log(achievement)
  #This is where you would update your DOM
```

###removed(callback)
`callback` is a function that will execute when an achievement with all it's required flags set to ON has a flag removed.

####Example
```coffeescript
achievements.removed (achievement) ->
  console.log("Your user lost an achievement.  We have to tell them")
  console.log(achievement)
  #This is where you would give the user the bad news
```

#Changelog
v0.1.0 Initial documentation and unit-tested achievement system.

#License
Achieve is available under the MIT license.  We hope you find it useful.  Please let us at 255 BITS know if you use it for something cool.
