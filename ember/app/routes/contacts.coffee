`import BaseRoute from './base'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

AuthenticatedRoute = BaseRoute.extend(AuthenticatedRouteMixin)

`export default AuthenticatedRoute`