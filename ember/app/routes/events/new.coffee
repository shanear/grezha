`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EventsNewRoute = BaseRoute.extend AuthenticatedRouteMixin,
  resetController: ->
    @controller.set('isSaving', false)
    @store.deleteRecord(@controller.get('model'))

  model: (params)->
    startsAt = @get('datetime.now')()
    startsAt.setMinutes(0)

    @store.createRecord('event', { startsAt: startsAt });


`export default EventsNewRoute`