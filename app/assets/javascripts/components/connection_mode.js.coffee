App.ConnectionModeComponent = Ember.Component.extend
  classNames: ['mode-header']

  modeConnections: (->
    @get("contact.connections").filter (connection)=>
      connection.get("mode") == @get("mode")
  ).property("contact.connections.@each")

  isSelected: (->
    @get("mode") == @get("selected")
  ).property("selected")

  actions:
    select: (mode)-> @sendAction("onSelect", mode)
