`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

FilteredEventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  model: (params)->
    {
      events: @get('store').all('event')
      programs: @get('store').all('program')
      programFilter: @get('store').all('program').findBy('slug', params.program_slug)
    }

  setupController: (controller, model)->
    @controller.set('events', model.events)
    @controller.set('programs', model.programs)
    @controller.set('programFilter', model.programFilter)


`export default FilteredEventsRoute`