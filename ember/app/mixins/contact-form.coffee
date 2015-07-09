`import Ember from 'ember'`

ContactForm = Ember.Mixin.create
  genderOptions: ["Male", "Female", "Other"]

  showOtherGender: Ember.computed "gender", ->
    return false if !@get("gender")
    return true if @get("gender") == "other"
    return !@get("genderOptions").contains(@get("gender").capitalize())

  otherGender: Ember.computed "gender", (key, value)->
    @set("gender", value.toLowerCase()) if value
    return "" if @get("gender") == "other"
    return (@get("gender") || "").capitalize()

  selectedGender: Ember.computed "gender", (key, value)->
    @set("gender", value && value.toLowerCase()) if (arguments.length > 1)
    return if !@get("gender")
    if @get("showOtherGender")
      "Other"
    else
      @get("gender").capitalize()

`export default ContactForm`