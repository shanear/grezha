`import Ember from 'ember'`

ContactForm = Ember.Mixin.create
  genderOptions: ["Male", "Female", "Other"]

  showOtherGender: Ember.computed "gender", ->
    return false if !@get("gender")
    return true if @get("gender") == "other"
    return !@get("genderOptions").contains(@get("gender").capitalize())

  setSelectedGender: Ember.observer "gender", "showOtherGender", ->
    if @get("showOtherGender")
      @set("selectedGender", "Other")
    else
      @set("selectedGender", (@get("gender") || "").capitalize())

  setGender: Ember.observer "selectedGender", "otherGender", ->
    if(!@get("showOtherGender"))
      value = @get("selectedGender")
      @set("gender", @get("selectedGender") && @get("selectedGender").toLowerCase())
    else
      @set("gender", (@get("otherGender") || "other").toLowerCase())

  setOtherGender: Ember.observer "gender", ->
    if @get("gender") == "other"
      @set("otherGender", "")
    else
      @set("otherGender", (@get("gender") || "").capitalize())


`export default ContactForm`