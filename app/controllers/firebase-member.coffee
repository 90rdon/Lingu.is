firebaseMemberController = Ember.Controller.extend
  find: (id) ->
    new Promise (resolve, reject) ->
      memberRef = new Firebase App.firebaseUri + '/members/' + id
      memberRef.once 'value', (snapshot) ->
        resolve(snapshot.val())

  create: (user) ->
    new Promise (resolve, reject) ->
      self = @
      
      memberRef = new Firebase App.firebaseUri + '/members/' + user.id
      memberRef.setWithPriority user, user.displayName || user.name || ''
      resolve(user)

`export default firebaseMemberController`