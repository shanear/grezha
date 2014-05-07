# Controls are any elements used for manipulating data
App.ControlGroupComponent = Ember.Component.extend
  tagName: 'div'
  classNameBindings: ['name', 'disabled:disabled-control']
  disabledBinding: Ember.Binding.oneWay('App.readonly')