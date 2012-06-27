# Achieve
This API is a framework/persistence agnostic API for defining user-based
Achievements.

High Level Overview:
*Achievements are defined as a list of required flags.
*Flags are set in the browser when a user reaches certain checkpoints.
*User-defined events are triggered when achievements get all the required flags.

API Documentation:
```coffeescript
# This creates a new achievement definition.  This will not
# give a user an achievement.
# required is a list of flags that the achievement requires to activate
# object is the achievement object that is passed to the listening callback
achievements.define(required, object)
```

Usage:
```coffeescript
achievements.define(['validPicture', 'validName'], {
  name: 'profileSetup',
  icon: '/badges/profileSetup.png',
  message: 'Congratulations!  Your profile is now setup.',
  removalMessage: "Fix your profile buddy."
})
```

Then, as your user sets up his profile

```coffeescript
achievements.flag('validPicture')
achievements.flag('validName')
```

Or, if the user removes their profile picture

```coffeescript
achievements.removeFlag('validPicture')
```


This, by itself, won't accomplish anything in your app.  You must provide
a listener to handle achievement events.

```coffeescript
achievements.received (achievement) ->
  console.log("User has a new achievement!")
  console.log(achievement)
  #This is where you would update your DOM

achievements.removed (achievement) ->
  console.log("Your user lost an achievement.  We have to tell them")
  console.log(achievement)
  #This is where you would give the user the bad news

```
