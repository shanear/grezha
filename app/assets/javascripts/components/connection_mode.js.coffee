App.ConnectionModeComponent = Ember.Component.extend
  classNames: ['mode-header']
  classNameBindings: ['hasConnections']

  hasConnections: (->
    @get('modeConnections.length') > 0
  ).property('modeConnections.@each')

  modeConnections: (->
    @get("contact.connections").filter (connection)=>
      connection.get("mode") == @get("mode")
  ).property("contact.connections.@each")

  isSelected: (->
    @get("mode") == @get("selected")
  ).property("selected")

  actions:
    select: (mode)-> @sendAction("onSelect", mode)
