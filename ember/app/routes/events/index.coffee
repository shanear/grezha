`import BaseRoute from '../base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

FilteredEventsRoute = BaseRoute.extend AuthenticatedRouteMixin,
  resetController: ->
    @controller.set('isChangingFilter', false)

  model: (params)->
    {
      programFilter: @get('store').all('program').findBy('slug', params.program_slug)
      status: params.status
    }

  setupController: (controller, model)->
    @controller.set('events', @get('store').all('event'))
    @controller.set('programs', @get('store').all('program'))
    @controller.set('programFilter', model.programFilter)
    @controller.set('status', model.status)

  serialize: (model)->
    {
      program_slug: if model.programFilter then model.programFilter.get('slug') else 'all',
      status: model.status
    }


`export default FilteredEventsRoute`