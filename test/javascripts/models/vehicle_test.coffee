store = vehicle = null

moduleForModel 'vehicle', 'Vehicle Model', 
  needs: ['model:vehicle']
  setup: ->
    store = @store()
    Ember.run -> 
      vehicle = store.createRecord('vehicle', licensePlate: "license")

test 'isValid', -> 
  ok(vehicle.isValid(), "vehicle is valid with a valid license")
  Ember.run -> 
    vehicle.set("licensePlate", "")
  equal(vehicle.isValid(), false, "vehicle needs to be with a non blank license plate")
  equal(vehicle.errors, "License plate is blank", "License plate should be blank")
  Ember.run ->
    vehicle.set("licensePlate", undefined)
  equal(vehicle.isValid(), false, "vehicle cannot be undefined")
  equal(vehicle.errors, "Name is undefined", "License plate should be undefined")