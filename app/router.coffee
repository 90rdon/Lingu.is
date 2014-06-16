Router = Ember.Router.extend()

Router.map ->
  @route 'member', path: '/:member_id'
  # @route 'test', path: '/test'
  # @route 'component-test'
  # @route 'helper-test'

Router.reopen
  location: 'hash'

`export default Router`