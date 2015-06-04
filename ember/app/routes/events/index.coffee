`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

FilteredEventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    {
      events: @get('store').all('event')
      programFilter: @get('store').all('program').findBy('slug', params.program_slug)
    }

  setupController: (controller, model)->
    @controller.set('events', model.events)
    @controller.set('programFilter', model.programFilter)


`export default FilteredEventsRoute`