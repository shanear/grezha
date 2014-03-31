App.Router.map () ->
  @resource 'vehicles'

  @resource 'contacts', ->
    @route 'new'
    @route 'new', { path: "/new/:name" }
    @resource 'contact', { path: "/:contact_id" }, ->
      @route 'edit'
