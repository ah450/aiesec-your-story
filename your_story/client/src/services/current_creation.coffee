angular.module 'aiesec'
  .factory 'currentCreation', ()->
    creation =
      createParticipant: ->
        @participantPromise = @participant.save()
      createAvatar: ->
        @participantPromise.then (participant) =>
          participant.createAvatar @avatar
