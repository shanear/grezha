App.Router.map () ->
  @resource 'vehicles', ->
    @resource 'vehicle', { path: "/:vehicle_id" }, ->
      @route 'edit'

  @resource 'contacts', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'contact', { path: "/:contact_id" }, ->
      @route 'edit'
