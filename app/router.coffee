Router = Ember.Router.extend()

Router.map ->
  @route 'member', path: '/:member_id'
  @route 'call', path: '/call/:call_id'

Router.reopen
  location: 'hash'

`export default Router`