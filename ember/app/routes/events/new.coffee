`import Ember from 'ember'`
`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  resetController: ->
    @controller.set('errors', [])
    @controller.set('isSaving', false)
    @controller.set('newProgramName', "")
    @controller.set('selectedProgram', null)

    if @controller.get("model.isNew")
      @store.deleteRecord(@controller.get('model'))

    if @controller.get("newProgram.isNew")
      @store.deleteRecord(@controller.get('newProgram'))

  model: (params)->
    startsAt = @get('datetime.now')()
    startsAt.setMinutes(0)

    Ember.RSVP.hash({
      newEvent: @store.createRecord('event', { startsAt: startsAt })
      programs: @store.find('program')
    });

  setupController: (controller, model)->
    @controller.set('programs', model.programs)
    @controller.set('model', model.newEvent)
    @controller.set('newProgram',
      @store.createRecord('program', { name: 'Add a program' })
    )


`export default EventsNewRoute`