class App.Contact extends Spine.Model
  @configure 'Contact', 'name', 'bio'

  @extend Spine.Model.Local
  @extend Spine.Model.Ajax

  # Every time contacts are refreshed (from the server), 
  # cache them to localStorage for offline use
  @bind 'refresh', @saveLocal

  # If remote load fails, attempt to load from local storage
  @bind 'ajaxError', @loadLocal
