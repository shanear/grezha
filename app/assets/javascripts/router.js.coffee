App.Router.map () ->
  @route 'logout'
  @resource 'vehicles', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'vehicle', { path: "/:vehicle_id" }, ->
      @route 'edit'

  @resource 'contacts', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'contact', { path: "/:contact_id" }, ->
      @route 'edit'
      @resource 'relationships', ->
        @route 'new'
        @resource 'relationship', {path: "/:relationship_id"}, ->
          @route 'edit'