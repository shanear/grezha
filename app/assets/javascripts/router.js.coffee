App.Router.map () ->
  @route 'logout'

  @resource 'vehicles', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'vehicle', { path: "/:vehicle_id" }, ->
      @route 'edit'

  @resource 'contacts', { path: '/clients' }, ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'contact', { path: "/:contact_id" }, ->
      @route 'edit'
      @resource 'people', ->
        @resource 'person', {path: "/:person_id"}, ->
          @route 'edit'

  @route 'birthdays'
