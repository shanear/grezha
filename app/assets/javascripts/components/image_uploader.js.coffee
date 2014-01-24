App.ImageUploaderComponent = Ember.Component.extend
  templateName: "components/image-uploader"

  uploadUrl: (->
    "/api/v1/#{@get('resource')}/#{@get('resourceId')}/upload_image"
  ).property('resourceId')

  applyFileUploader: (->
    @$('input').fileupload
      dataType: 'json'
      start: (e, data)=>
        @sendAction('action', "assets/loading.gif")
      done: (e, data) =>
        @sendAction('action', data.result.imageUrl)
  ).on("didInsertElement")