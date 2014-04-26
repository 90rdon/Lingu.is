firebaseProfileController = Ember.Controller.extend
  needs: [
    'firebase-member'
  ]

  findByUID: (identity) ->
    new Promise (resolve, reject) ->
      new Firebase App.firebaseUri + '/profiles'
        .startAt(identity.uid)    
        .endAt(identity.uid)
        .once 'value', (snapshot) ->
          if snapshot.val()
            snapshot.forEach (profile) ->
              resolve(profile)
          else
            reject(error: 'Cannot find profile') 

  create: (member, identity) ->
    profile = 
      memberId:     member.id
      identity:     identity
      '.priority':  identity.uid

    new Promise (resolve, reject) ->
      profileRef = new Firebase App.firebaseUri + '/Profiles'
      profileRef.push profile

      resolve(profile)

`export default firebaseProfileController`