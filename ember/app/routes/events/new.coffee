`import Ember from 'ember'`
`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  resetController: ->
    @controller.set('errors', [])
    @controller.set('isSaving', false)
    @store.deleteRecord(@controller.get('model'))

  model: (params)->
    startsAt = @get('datetime.now')()
    startsAt.setMinutes(0)

    Ember.RSVP.hash({
      newEvent: @store.createRecord('event', { startsAt: startsAt });
      programs: @store.find('program');
    });

  setupController: (controller, model)->
    @controller.set('programs', model.programs)
    @controller.set('model', model.newEvent)


`export default EventsNewRoute`