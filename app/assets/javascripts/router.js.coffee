App.Router.map () ->
  @route 'logout'
  @route 'TEST'

  @resource 'vehicles', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'vehicle', { path: "/:vehicle_id" }, ->
      @route 'edit'

  @route 'ihate', {path: "/relationships/:relationship_id"}


  @resource 'contacts', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'contact', { path: "/:contact_id" }, ->
      @route 'edit'
      @resource 'relationships', ->
        @route 'new'
        @resource 'relationship', {path: "/:relationship_id"}, ->
          @route 'edit'