App.Router.map () ->
  @resource 'contacts', ->
    @route 'new'
    @resource 'contact', { path: "/:contact_id" }, ->
      @route 'edit'
